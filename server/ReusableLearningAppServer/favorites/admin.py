from django.contrib import admin

from favorites.models import FavoriteCourses, FavoriteLessons

admin.site.register(FavoriteCourses)
admin.site.register(FavoriteLessons)
