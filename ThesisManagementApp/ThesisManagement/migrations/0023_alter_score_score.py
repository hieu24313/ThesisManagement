# Generated by Django 4.2.7 on 2023-12-26 19:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ThesisManagement', '0022_alter_score_lecturer_alter_score_student'),
    ]

    operations = [
        migrations.AlterField(
            model_name='score',
            name='score',
            field=models.FloatField(null=True),
        ),
    ]
