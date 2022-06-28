from rest_framework import viewsets, permissions
from courses.serializers import CourseSerializer
from courses.models import Course


class CourseViewSet(viewsets.ModelViewSet):
    queryset = Course.objects.all()
    serializer_class = CourseSerializer
    permission_classes = [permissions.IsAuthenticated]

