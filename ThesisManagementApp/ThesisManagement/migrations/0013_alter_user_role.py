# Generated by Django 4.2.7 on 2023-12-05 06:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ThesisManagement', '0012_alter_user_role'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='role',
            field=models.CharField(blank=True, choices=[('admin', 'Admin'), ('universityadministrator', 'universityadministrator'), ('lecturer', 'lecturer'), ('student', 'student')], default='student', max_length=50, null=True),
        ),
    ]
