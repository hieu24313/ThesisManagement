# Generated by Django 4.2.7 on 2024-01-25 04:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ThesisManagement', '0035_remove_message_created_at'),
    ]

    operations = [
        migrations.AddField(
            model_name='message',
            name='created_at',
            field=models.DateTimeField(auto_now_add=True, null=True),
        ),
    ]
