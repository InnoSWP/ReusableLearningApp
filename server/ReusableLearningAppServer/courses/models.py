from django.db import models
from django.contrib.auth.models import User


class Course(models.Model):
    name = models.CharField(max_length=64)
    description = models.TextField()
    users = models.ManyToManyField(User, related_name='course_list', blank=True)

    def __str__(self):
        return f'Course {self.name}'
