from rest_framework import viewsets, permissions
from lessons.serializers import LessonSerializer
from lessons.models import Lesson


class LessonViewSet(viewsets.ModelViewSet):
    queryset = Lesson.objects.all()
    serializer_class = LessonSerializer
    permission_classes = [permissions.IsAuthenticated]
