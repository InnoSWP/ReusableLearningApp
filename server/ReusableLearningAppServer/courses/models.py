from django.db import models
from django.core.exceptions import ValidationError
from django.contrib.auth.models import User


def validate_points(points: int):
    if not (1 <= points <= 20):
        raise ValidationError(
            f"Points must be in [1; 20]; current - {points}"
        )


class Course(models.Model):
    name = models.CharField(max_length=64)
    description = models.TextField()
    points_per_lesson = models.IntegerField(default=5, validators=[validate_points])
    users = models.ManyToManyField(User, related_name='course_list', blank=True)

    def __str__(self):
        return f'Course {self.name}'

    @classmethod
    def get_users_courses(cls, user: User):
        return cls.objects.filter(users=user).all()
