from django.db import models
from django.contrib.auth.models import User


class Course(models.Model):
    name = models.CharField(max_length=64)
    description = models.TextField()
    users = models.ManyToManyField(User, blank=True)

    def __str__(self):
        return f'{self.name}'
