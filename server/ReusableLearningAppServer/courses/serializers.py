from rest_framework import serializers

from courses.models import Course
from lessons.serializers import LessonSerializer


class CourseSerializer(serializers.HyperlinkedModelSerializer):
    users = serializers.PrimaryKeyRelatedField(read_only=True, many=True)
    lessons = LessonSerializer(many=True, read_only=True)

    class Meta:
        model = Course
        fields = ['id', 'name', 'description', 'users', 'lessons']
        read_only_fields = ['id']
