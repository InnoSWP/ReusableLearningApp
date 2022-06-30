from rest_framework import serializers

from courses.models import Course
from lessons.models import Lesson
from progress.models import LessonProgress


class LessonProgressSerializer(serializers.ModelSerializer):
    class Meta:
        model = LessonProgress
        fields = ['lesson', 'status']


class CourseProgressSerializer(serializers.ModelSerializer):
    lessons = LessonProgressSerializer(read_only=True, many=True)
    progress = serializers.IntegerField(read_only=True)

    class Model:
        model = Course
        fields = ["id"]

    def to_representation(self, instance):
        user = self.context["request"].user
        users_lessons = LessonProgress.objects.filter(lesson__course_id=instance.pk, user=user).all()
        lessons_amount = Lesson.objects.filter(course=instance).count()

        progress = (lessons_amount and users_lessons.filter(
            status=LessonProgress.StatusType.COMPLETED
        ).count()) / (lessons_amount or 1)
        return {
            "id": instance.pk,
            "lessons": LessonProgressSerializer(users_lessons, many=True).data,
            "progress": progress
        }



