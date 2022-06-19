import os

from django.contrib.auth.models import User
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    def handle(self, *args, **options):
        user = User.objects.create_superuser(
            username=os.getenv('SUPERADMIN_LOGIN'),
            email=os.getenv('SUPERADMIN_EMAIL'),
            password=os.getenv('SUPERADMIN_PASSWORD')
        )
        user.save()
