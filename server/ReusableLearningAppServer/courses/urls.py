from django.urls import path

from courses.views import CourseViewSet

urlpatterns = [
    path('list/', CourseViewSet.as_view({'get': 'list'}), name='list'),
    path('<int:id>/', CourseViewSet.as_view({'get': 'retrieve'}), name='id')
]