# Generated by Django 4.2.7 on 2023-12-22 08:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ThesisManagement', '0016_thesis_status'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='thesisdefensecommittee',
            name='thesis',
        ),
        migrations.AddField(
            model_name='thesis',
            name='committee',
            field=models.ManyToManyField(to='ThesisManagement.thesisdefensecommittee'),
        ),
    ]
