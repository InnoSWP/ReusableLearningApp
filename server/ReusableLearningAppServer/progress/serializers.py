from rest_framework import serializers

from progress.models import LessonProgress


class LessonProgressSerializer(serializers.ModelSerializer):
    class Meta:
        model = LessonProgress
        fields = ['user', 'lesson', 'status']
