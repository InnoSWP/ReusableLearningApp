from rest_framework.response import Response
from rest_framework.viewsets import ReadOnlyModelViewSet
from rest_framework.generics import GenericAPIView
from rest_framework import permissions

from lessons.models import Lesson
from courses.models import Course
from points.models import UserScore
from progress.models import LessonProgress
from progress.serializers import CourseProgressSerializer


def check_course_existence(func):
    def wrapper(*args, **kwargs):
        try:
            return func(*args, **kwargs)
        except (Course.DoesNotExist, Lesson.DoesNotExist, LessonProgress.DoesNotExist):
            return Response(status=404)
    return wrapper


class CourseProgressView(ReadOnlyModelViewSet):
    """
    ░░░░░▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░
    ░░░▓▓▓▓▓▓▒▒▒▒▒▒▓▓░░░░░░░
    ░░▓▓▓▓▒░░▒▒▓▓▒▒▓▓▓▓░░░░░
    ░▓▓▓▓▒░░▓▓▓▒▄▓░▒▄▄▄▓░░░░
    ▓▓▓▓▓▒░░▒▀▀▀▀▒░▄░▄▒▓▓░░░
    ▓▓▓▓▓▒░░▒▒▒▒▒▓▒▀▒▀▒▓▒▓░░
    ▓▓▓▓▓▒▒░░░▒▒▒░░▄▀▀▀▄▓▒▓░
    ▓▓▓▓▓▓▒▒░░░▒▒▓▀▄▄▄▄▓▒▒▒▓
    ░▓█▀▄▒▓▒▒░░░▒▒░░▀▀▀▒▒▒▒░
    ░░▓█▒▒▄▒▒▒▒▒▒▒░░▒▒▒▒▒▒▓░
    ░░░▓▓▓▓▒▒▒▒▒▒▒▒░░░▒▒▒▓▓░
    ░░░░░▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▓▓░
    ░░░░░░▓▒▒░░░░▒▒▒▒▒▒▒▓▓░░
    """

    permission_classes = [permissions.IsAuthenticated]
    serializer_class = CourseProgressSerializer
    queryset = Course.objects.all()


class LessonProgressView(GenericAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = CourseProgressSerializer

    def get_progress(self, course_id: int) -> dict:
        return self.get_serializer(Course.objects.get(pk=course_id)).data

    @check_course_existence
    def post(self, request, course_id, lesson_id):
        """
        Creation progress when user starts a lesson
        """
        if LessonProgress.objects.filter(lesson_id=lesson_id, user=request.user).first():
            return Response(self.get_progress(course_id), status=200)

        LessonProgress.objects.create(
            lesson=Lesson.objects.get(pk=lesson_id),
            user=request.user
        )
        return Response(self.get_progress(course_id), status=201)

    @check_course_existence
    def put(self, request, course_id, lesson_id):
        """
        Marking progress as completed when user finishes a lesson
        """
        lesson_progress = LessonProgress.objects.get(lesson_id=lesson_id, user=request.user)
        if lesson_progress.status == LessonProgress.StatusType.COMPLETED:
            return Response({
                "reason": "lesson already completed"
            }, status=400)

        lesson_progress.status = LessonProgress.StatusType.COMPLETED
        lesson_progress.save()

        course = Course.objects.get(pk=course_id)
        UserScore.update_score(request.user, lambda x: x + course.points_per_lesson)

        return Response(self.get_progress(course.pk))
