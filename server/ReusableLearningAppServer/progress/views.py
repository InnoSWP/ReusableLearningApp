from rest_framework.views import APIView, Response
from rest_framework import permissions
from django.core.exceptions import ObjectDoesNotExist

from lessons.models import Lesson
from progress.models import LessonProgress
from progress.serializers import LessonProgressSerializer


def check_course_existence(func):
    def wrapper(*args, **kwargs):
        try:
            return func(*args, **kwargs)
        except (CourseDoesntExist, ObjectDoesNotExist):
            return Response(status=404)
    return wrapper


def get_progress(course_id, user):
    users_lessons = LessonProgress.objects.filter(lesson__course_id=course_id, user=user).all()
    lessons_amount = Lesson.objects.filter(course_id=course_id).count()
    if lessons_amount == 0:
        raise CourseDoesntExist()
    return {
        'lessons': LessonProgressSerializer(users_lessons, many=True).data,
        'progress': users_lessons.count() / lessons_amount
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
        lesson_progress = LessonProgress.objects.filter(lesson_id=lesson_id, user=request.user).first()
        if lesson_progress is not None:
            return Response(get_progress(course_id, request.user), status=200)
        lesson = Lesson.objects.get(pk=lesson_id)
        lesson_progress = LessonProgress(lesson=lesson, user=request.user)
        lesson_progress.save()
        return Response(get_progress(course_id, request.user), status=201)

    @check_course_existence
    def put(self, request, course_id, lesson_id):
        lesson_progress = LessonProgress.objects.filter(lesson_id=lesson_id, user=request.user).first()
        if lesson_progress:
            lesson_progress.status = LessonProgress.StatusType.COMPLETED
            lesson_progress.save()
            return Response(get_progress(course_id, request.user))
        return Response(status=404)


class CourseDoesntExist(Exception):
    pass
