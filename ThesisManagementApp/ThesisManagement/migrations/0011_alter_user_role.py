# Generated by Django 4.2.7 on 2023-12-04 12:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ThesisManagement', '0010_role_alter_user_role'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='role',
            field=models.CharField(default='student', max_length=50),
        ),
    ]
