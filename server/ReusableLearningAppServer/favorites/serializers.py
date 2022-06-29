from rest_framework import serializers

from favorites.models import FavoriteCourses, FavoriteLessons


class FavoriteCoursesSerializer(serializers.ModelSerializer):

    class Meta:
        model = FavoriteCourses
        fields = ['user', 'course']


class FavoriteLessonsSerializer(serializers.ModelSerializer):

    class Meta:
        model = FavoriteLessons
        fields = ['user', 'lesson']