from django.contrib import admin

from lessons.models import Lesson


@admin.register(Lesson)
class LessonAdmin(admin.ModelAdmin):
    list_display = ('name', 'level', 'display_course')

    @admin.display(description='Course name', empty_value='Nothing???')
    def display_course(self, obj):
        return obj.course.name
