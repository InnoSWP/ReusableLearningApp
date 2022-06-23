from django.urls import path

from favorites.views import UsersFavoriteCoursesView, FavoriteCoursesUsersView,\
    UsersFavoriteLessonsView, FavoriteLessonsUsersView, AddToFavoriteCourses, AddToFavoriteLessons

urlpatterns = [
    path('courses/courses/<int:user_id>/', UsersFavoriteCoursesView.as_view()),
    path('courses/users/<int:course_id>/', FavoriteCoursesUsersView.as_view()),
    path('lessons/lessons/<int:user_id>/', UsersFavoriteLessonsView.as_view()),
    path('lessons/users/<int:lesson_id>/', FavoriteLessonsUsersView.as_view()),
    path('courses/add/<int:course_id>/', AddToFavoriteCourses.as_view()),
    path('lessons/add/<int:lesson_id>/', AddToFavoriteLessons.as_view())
]
