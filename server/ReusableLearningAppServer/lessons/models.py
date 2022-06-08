from django.db import models
from courses.models import Course


class Lesson(models.Model):
    name = models.CharField(max_length=64)
    content = models.TextField()
    children_lessons = models.ForeignKey('self', on_delete=models.CASCADE)
    course = models.ForeignKey(Course, models.PROTECT)
