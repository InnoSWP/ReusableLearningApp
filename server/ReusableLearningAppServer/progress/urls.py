from django.urls import path

from progress.views import CourseProgressView, LessonProgressView

urlpatterns = [
    path('<int:course_id>/', CourseProgressView.as_view()),
    path('<int:course_id>/lesson/<int:lesson_id>/', LessonProgressView.as_view())
]
