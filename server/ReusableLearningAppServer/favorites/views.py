from rest_framework.views import APIView, Response
from rest_framework import permissions

from favorites.models import FavoriteCourses, FavoriteLessons
from favorites.serializers import FavoriteCoursesSerializer, FavoriteLessonsSerializer
from courses.serializers import CourseSerializer
from accounts.serializers import UserSerializer
from lessons.serializers import LessonSerializer


class UsersFavoriteCoursesView(APIView):
    permission_classes = [permissions.AllowAny]

    def get(self, request, user_id):
        return Response([x.course_id for x in FavoriteCourses.objects.filter(user__pk=user_id).all()])


class FavoriteCoursesUsersView(APIView):
    permission_classes = [permissions.AllowAny]

    def get(self, request, course_id):
        return Response([x.user_id for x in FavoriteCourses.objects.filter(course__pk=course_id).all()])


class UsersFavoriteLessonsView(APIView):
    permission_classes = [permissions.AllowAny]

    def get(self, request, user_id):
        return Response([x.lesson_id for x in FavoriteLessons.objects.filter(user__pk=user_id).all()])


class FavoriteLessonsUsersView(APIView):
    permission_classes = [permissions.AllowAny]

    def get(self, request, lesson_id):
        return Response([x.user_id for x in FavoriteLessons.objects.filter(lesson__pk=lesson_id).all()])
