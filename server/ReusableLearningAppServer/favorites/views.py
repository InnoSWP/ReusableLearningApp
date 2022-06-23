from rest_framework.views import APIView, Response
from rest_framework import permissions

from favorites.models import FavoriteCourses, FavoriteLessons
from favorites.serializers import FavoriteCoursesSerializer, FavoriteLessonsSerializer
from courses.models import Course


class UsersFavoriteCoursesView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, user_id):
        return Response([x.course_id for x in FavoriteCourses.objects.filter(user__pk=user_id).all()])


class FavoriteCoursesUsersView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, course_id):
        return Response([x.user_id for x in FavoriteCourses.objects.filter(course__pk=course_id).all()])


class UsersFavoriteLessonsView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, user_id):
        return Response([x.lesson_id for x in FavoriteLessons.objects.filter(user__pk=user_id).all()])


class FavoriteLessonsUsersView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, lesson_id):
        return Response([x.user_id for x in FavoriteLessons.objects.filter(lesson__pk=lesson_id).all()])


class AddToFavoriteCourses(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, course_id):
        serializer = FavoriteCoursesSerializer(
            FavoriteCourses.objects.filter(course_id=course_id, user=request.user).first(),
            data={'user': request.user.id,
                  'course': course_id}
        )
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response(serializer.data, 201)
        return Response(serializer.errors, 400)

    def delete(self, request, course_id):
        favorite_course = FavoriteCourses.objects.filter(course_id=course_id, user=request.user).first()
        if favorite_course is not None:
            favorite_course.delete()
            return Response(status=204)
        return Response(status=404)


class AddToFavoriteLessons(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, lesson_id):
        serializer = FavoriteLessonsSerializer(
            FavoriteLessons.objects.filter(lesson_id=lesson_id, user=request.user).first(),
            data={'user': request.user.id,
                  'lesson': lesson_id}
        )
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response(serializer.data, 201)
        return Response(serializer.errors, 400)

    def delete(self, request, lesson_id):
        favorite_lesson = FavoriteLessons.objects.filter(lesson_id=lesson_id, user=request.user).first()
        if favorite_lesson is not None:
            favorite_lesson.delete()
            return Response(status=204)
        return Response(status=400)
