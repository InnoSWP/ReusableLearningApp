# Generated by Django 4.0.5 on 2022-06-15 10:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('lessons', '0003_remove_lesson_children_lesson_course'),
    ]

    operations = [
        migrations.AddField(
            model_name='lesson',
            name='level',
            field=models.IntegerField(default=0),
        ),
    ]
