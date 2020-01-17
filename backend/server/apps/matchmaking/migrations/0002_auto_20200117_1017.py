# Generated by Django 2.2.9 on 2020-01-17 10:17

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('profile', '0001_initial'),
        ('matchmaking', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='match',
            name='investor',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='profile.InvestorProfile'),
        ),
        migrations.AddField(
            model_name='match',
            name='startup',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='profile.Startup'),
        ),
    ]
