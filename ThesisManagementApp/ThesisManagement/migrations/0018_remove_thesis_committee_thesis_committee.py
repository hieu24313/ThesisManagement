# Generated by Django 4.2.7 on 2023-12-22 09:10

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('ThesisManagement', '0017_remove_thesisdefensecommittee_thesis_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='thesis',
            name='committee',
        ),
        migrations.AddField(
            model_name='thesis',
            name='committee',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.RESTRICT, to='ThesisManagement.thesisdefensecommittee'),
        ),
    ]