# Generated by Django 4.0.5 on 2022-06-15 10:22

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0004_course_root_lesson'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='course',
            name='root_lesson',
        ),
    ]