from django.urls import path

from courses.views import CourseViewSet

urlpatterns = [
    path('list/', CourseViewSet.as_view({'get': 'list'}), name='course_list'),
    path('<int:pk>/', CourseViewSet.as_view({'get': 'retrieve'}), name='course_id')
]
