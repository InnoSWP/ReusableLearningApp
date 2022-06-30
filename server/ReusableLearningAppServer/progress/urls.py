from django.urls import path, include
from rest_framework.routers import DefaultRouter

from progress.views import CourseProgressView, LessonProgressView

router = DefaultRouter()
router.register("", CourseProgressView)

urlpatterns = [
    path("", include(router.urls)),
    path('<int:course_id>/lesson/<int:lesson_id>/', LessonProgressView.as_view())
]
