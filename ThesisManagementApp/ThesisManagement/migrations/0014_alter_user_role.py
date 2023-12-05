# Generated by Django 4.2.7 on 2023-12-05 07:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ThesisManagement', '0013_alter_user_role'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='role',
            field=models.CharField(blank=True, choices=[('admin', 'Quản Trị Viên'), ('universityadministrator', 'Giáo Vụ'), ('lecturer', 'Giảng Viên'), ('student', 'Sinh Viên')], default='student', max_length=50, null=True),
        ),
    ]
