from django.db import models
from django.contrib.auth.models import User

from lessons.models import Lesson


class LessonProgress(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    lesson = models.ForeignKey(Lesson, on_delete=models.CASCADE)

    class StatusType(models.TextChoices):
        IN_PROGRESS = 'PR', 'In progress'
        COMPLETED = 'CM', 'Completed'

    status = models.CharField(max_length=2, choices=StatusType.choices, default=StatusType.IN_PROGRESS)
