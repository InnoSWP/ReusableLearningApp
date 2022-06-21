from django.contrib.auth.models import User
from rest_framework import serializers

from courses.serializers import CourseSerializer


class UserSerializer(serializers.ModelSerializer):
    course_list = CourseSerializer(many=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'course_list', 'favorite_courses', 'favorite_lessons']


class RegisterSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['username', 'password', 'email']
        write_only_fields = ['password']

    def create(self, validated_data):
        user = User.objects.create(
            username=validated_data['username'],
            email=validated_data['email']
        )

        user.set_password(validated_data['password'])
        user.save()

        return user
