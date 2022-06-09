from rest_framework import serializers

from lessons.models import Lesson


class LessonSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Lesson
        fields = ['name', 'content', 'children_lessons', 'course']
