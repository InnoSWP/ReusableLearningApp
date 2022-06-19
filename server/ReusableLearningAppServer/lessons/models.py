from django.db import models
from courses.models import Course


class Lesson(models.Model):
    name = models.CharField(max_length=64)
    content = models.TextField()
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name='lessons')
    level = models.IntegerField(default=0)

    class Meta:
        ordering = ['level']

    def __str__(self):
        return f'Lesson {self.name} of course {self.course.name} of level: {self.level}'
