from django.urls import path

from favorites.views import UsersFavoriteCoursesView, FavoriteCoursesUsersView,\
    UsersFavoriteLessonsView, FavoriteLessonsUsersView

urlpatterns = [
    path('courses/courses/<int:user_id>/', UsersFavoriteCoursesView.as_view()),
    path('courses/users/<int:course_id>/', FavoriteCoursesUsersView.as_view()),
    path('lessons/lessons/<int:user_id>/', UsersFavoriteLessonsView.as_view()),
    path('lessons/users/<int:lesson_id>/', FavoriteLessonsUsersView.as_view())
]
