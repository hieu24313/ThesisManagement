# Generated by Django 4.2.7 on 2023-12-26 19:00

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('ThesisManagement', '0020_rename_memberofcommittee_score_lecturer_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='score',
            name='criteria',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='ThesisManagement.criteria'),
        ),
    ]
