from rest_framework.views import APIView, Response
from rest_framework import permissions

from lessons.models import Lesson
from courses.models import Course
from points.models import UserScore
from progress.models import LessonProgress
from progress.serializers import LessonProgressSerializer


def check_course_existence(func):
    def wrapper(*args, **kwargs):
        try:
            return func(*args, **kwargs)
        except (Course.DoesNotExist, Lesson.DoesNotExist, LessonProgress.DoesNotExist):
            return Response(status=404)
    return wrapper


def get_progress(course_id, user, added_points=0):
    users_lessons = LessonProgress.objects.filter(lesson__course_id=course_id, user=user).all()
    lessons_amount = Lesson.objects.filter(
        course=Course.objects.get(pk=course_id)
    ).count()
    points = {
        "added_points": added_points
    }
    return {
        'lessons': LessonProgressSerializer(users_lessons, many=True).data,
        'progress': (lessons_amount and users_lessons.filter(
            status=LessonProgress.StatusType.COMPLETED
        ).count()) / (lessons_amount or 1),
        **(points if added_points else {})
    }


class CourseProgressView(APIView):
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

    @check_course_existence
    def get(self, request, course_id):
        return Response(get_progress(course_id, request.user), status=200)


class LessonProgressView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    @check_course_existence
    def post(self, request, course_id, lesson_id):
        """
        Creation progress when user starts a lesson
        """
        if LessonProgress.objects.filter(lesson_id=lesson_id, user=request.user).first():
            return Response(get_progress(course_id, request.user), status=200)

        LessonProgress.objects.create(
            lesson=Lesson.objects.get(pk=lesson_id),
            user=request.user
        )
        return Response(get_progress(course_id, request.user), status=201)

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

        return Response(get_progress(course_id, request.user, added_points=course.points_per_lesson))
