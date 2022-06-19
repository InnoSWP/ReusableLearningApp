from django.urls import path

from lessons.views import LessonViewSet

urlpatterns = [
    path('list/', LessonViewSet.as_view({'get': 'list'}), name='lesson_list'),
    path('<int:pk>/', LessonViewSet.as_view({'get': 'retrieve'}), name='lesson_id')
]