from django.db import models
from django.contrib.auth.models import User

from courses.models import Course
from lessons.models import Lesson


class FavoriteCourses(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='favorite_courses')
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name='favorite_courses')

    def __str__(self):
        return f"{self.user.username}'s favorite course {self.course.name}"


class FavoriteLessons(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='favorite_lessons')
    lesson = models.ForeignKey(Lesson, on_delete=models.CASCADE, related_name='favorite_lessons')

    def __str__(self):
        return f"{self.user.username}'s favorite lesson {self.lesson.name}"
