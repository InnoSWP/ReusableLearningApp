from django.contrib import admin

from courses.models import Course


@admin.register(Course)
class CourseAdmin(admin.ModelAdmin):
    list_display = ('name', 'display_description', 'display_students', 'display_lessons')

    @admin.display(description='Course description', empty_value='<i>none</i>')
    def display_description(self, obj):
        return obj.description[:128]

    @admin.display(description='Number of students', empty_value='0')
    def display_students(self, obj):
        return obj.users.count()

    @admin.display(description='Number of lessons', empty_value='0')
    def display_lessons(self, obj):
        return obj.lessons.count()
