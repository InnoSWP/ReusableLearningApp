from django.contrib.auth.models import User
from rest_framework import serializers

from courses.models import Course


class CourseSerializer(serializers.HyperlinkedModelSerializer):
    users = serializers.PrimaryKeyRelatedField(queryset=User.objects.all(), many=True)

    class Meta:
        model = Course
        fields = ['id', 'name', 'description', 'users']
        read_only_fields = ['id']
