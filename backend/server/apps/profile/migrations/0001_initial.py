# -*- coding: utf-8 -*-

# Generated by Django 2.2.9 on 2020-01-17 10:17

import django.contrib.postgres.fields
import django.contrib.postgres.fields.ranges
import django.contrib.postgres.validators
import django.db.models.deletion
import django.utils.timezone
import django_countries.fields
import phonenumber_field.modelfields
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [('auth', '0011_update_proxy_permissions')]

    operations = [
        migrations.CreateModel(
            name='User',
            fields=[
                (
                    'id',
                    models.AutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name='ID',
                    ),
                ),
                ('password',
                 models.CharField(max_length=128, verbose_name='password')),
                (
                    'last_login',
                    models.DateTimeField(
                        blank=True, null=True, verbose_name='last login',
                    ),
                ),
                (
                    'is_superuser',
                    models.BooleanField(
                        default=False,
                        help_text='Designates that this user has all'
                                  ' permissions without '
                                  'explicitly assigning them.',
                        verbose_name='superuser status',
                    ),
                ),
                (
                    'email',
                    models.EmailField(
                        db_index=True, max_length=254, unique=True,
                    ),
                ),
                ('is_staff', models.BooleanField(default=False)),
                ('is_active', models.BooleanField(default=True)),
                (
                    'groups',
                    models.ManyToManyField(
                        blank=True,
                        help_text='The groups this user belongs to.'
                                  'A user will get all permissions granted'
                                  ' to each of their groups.',
                        related_name='user_set',
                        related_query_name='user',
                        to='auth.Group',
                        verbose_name='groups',
                    ),
                ),
                (
                    'user_permissions',
                    models.ManyToManyField(
                        blank=True,
                        help_text='Specific permissions for this user.',
                        related_name='user_set',
                        related_query_name='user',
                        to='auth.Permission',
                        verbose_name='user permissions',
                    ),
                ),
            ],
            options={'abstract': False},
        ),
        migrations.CreateModel(
            name='InvestorProfile',
            fields=[
                (
                    'id',
                    models.AutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name='ID',
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name='Profile',
            fields=[
                (
                    'id',
                    models.AutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name='ID',
                    ),
                ),
                ('name', models.CharField(max_length=255)),
                (
                    'date_joined',
                    models.DateTimeField(default=django.utils.timezone.now),
                ),
                (
                    'user',
                    models.OneToOneField(
                        on_delete=django.db.models.deletion.CASCADE,
                        to=settings.AUTH_USER_MODEL,
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name='Startup',
            fields=[
                (
                    'id',
                    models.AutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name='ID',
                    ),
                ),
                ('website', models.URLField(blank=True)),
                (
                    'phone_number',
                    phonenumber_field.modelfields.PhoneNumberField(
                        max_length=128, region=None,
                    ),
                ),
                ('country', django_countries.fields.CountryField(max_length=2)),
                ('founding_date', models.DateField()),
                ('description', models.TextField(blank=True)),
                (
                    'stage',
                    models.CharField(
                        choices=[
                            ('CONCEPT_STAGE', 'Concept stage'),
                            (
                                'GROWTH_STAGE',
                                'Growth stage (generating revenue)',
                            ),
                            ('EARLY_STAGE', 'Early stage (market launch)'),
                            ('SEED_STAGE', 'Seed stage (product development)'),
                        ],
                        max_length=33,
                    ),
                ),
                (
                    'sectors',
                    django.contrib.postgres.fields.ArrayField(
                        base_field=models.CharField(
                            choices=[
                                ('AI_AND_ROBOTICS', 'AI and robotics'),
                                ('IOT_AND_SENSORS', 'IoT and sensors'),
                                ('AGRICULTURE', 'Agriculture'),
                            ],
                            max_length=15,
                        ),
                        size=None,
                    ),
                ),
                (
                    'industries',
                    django.contrib.postgres.fields.ArrayField(
                        base_field=models.CharField(
                            choices=[
                                ('BUSINESS_ANALYTICS', 'Business & Analytics'),
                                (
                                    'FINANCIAL_SERVICES',
                                    'Financial Services & Security',
                                ),
                                ('ENTERTAINMENT', 'Entertainment and Mobile'),
                                ('HEALTH_CARE', 'Health-care and Wellbeing'),
                                ('E_COMMERCE', 'E-commerce, Adtech, Martech'),
                                ('MATERIALS', 'Manufacturing and materials'),
                                ('HARDWARE', 'Hardware & Iot'),
                                ('MOBILITY', 'Mobility & Transportation'),
                                ('ENERGY', 'Energy and Cleantech'),
                            ],
                            max_length=29,
                        ),
                        size=None,
                    ),
                ),
                (
                    'product_types',
                    django.contrib.postgres.fields.ArrayField(
                        base_field=models.CharField(
                            choices=[
                                ('SOFTWARE', 'Software'),
                                ('HARDWARE', 'Hardware'),
                                ('OTHER', 'Other'),
                            ],
                            max_length=8,
                        ),
                        size=None,
                    ),
                ),
                (
                    'investment_stage',
                    django.contrib.postgres.fields.ArrayField(
                        base_field=models.CharField(
                            choices=[
                                ('BUSINESS_ANGELS', 'Business Angels'),
                                ('INCUBATOR', 'Incubator'),
                                ('VENTURE_CAPITAL', 'Venture Capital'),
                                ('ACCELERATOR', 'Accelerator'),
                            ],
                            max_length=15,
                        ),
                        size=None,
                    ),
                ),
                ('is_product_on_market', models.BooleanField()),
                (
                    'business_type',
                    models.CharField(
                        choices=[
                            ('B2B', 'Business to Business'),
                            ('B2C', 'Business to Customer'),
                        ],
                        max_length=3,
                    ),
                ),
                (
                    'investment_size',
                    django.contrib.postgres.fields.ranges.IntegerRangeField(
                        validators=[
                            django.contrib.postgres.validators.RangeMinValueValidator(
                                0,
                            ),
                            django.contrib.postgres.validators.RangeMaxValueValidator(
                                2147483647,
                            ),
                        ],
                    ),
                ),
                ('name', models.CharField(max_length=255, unique=True)),
                ('email', models.EmailField(max_length=254, unique=True)),
                ('logotype', models.ImageField(blank=True, upload_to='')),
            ],
            options={'abstract': False},
        ),
        migrations.CreateModel(
            name='AngelInvestor',
            fields=[
                (
                    'investorprofile_ptr',
                    models.OneToOneField(
                        auto_created=True,
                        on_delete=django.db.models.deletion.CASCADE,
                        parent_link=True,
                        primary_key=True,
                        serialize=False,
                        to='profile.InvestorProfile',
                    ),
                ),
                ('website', models.URLField(blank=True)),
                (
                    'phone_number',
                    phonenumber_field.modelfields.PhoneNumberField(
                        max_length=128, region=None,
                    ),
                ),
                ('country', django_countries.fields.CountryField(max_length=2)),
                ('founding_date', models.DateField()),
                ('description', models.TextField(blank=True)),
                (
                    'stage',
                    models.CharField(
                        choices=[
                            ('CONCEPT_STAGE', 'Concept stage'),
                            (
                                'GROWTH_STAGE',
                                'Growth stage (generating revenue)',
                             ),
                            ('EARLY_STAGE', 'Early stage (market launch)'),
                            ('SEED_STAGE', 'Seed stage (product development)'),
                        ],
                        max_length=33,
                    ),
                ),
                (
                    'sectors',
                    django.contrib.postgres.fields.ArrayField(
                        base_field=models.CharField(
                            choices=[
                                ('AI_AND_ROBOTICS', 'AI and robotics'),
                                ('IOT_AND_SENSORS', 'IoT and sensors'),
                                ('AGRICULTURE', 'Agriculture'),
                            ],
                            max_length=15,
                        ),
                        size=None,
                    ),
                ),
                (
                    'industries',
                    django.contrib.postgres.fields.ArrayField(
                        base_field=models.CharField(
                            choices=[
                                ('BUSINESS_ANALYTICS', 'Business & Analytics'),
                                (
                                    'FINANCIAL_SERVICES',
                                    'Financial Services & Security',
                                ),
                                ('ENTERTAINMENT', 'Entertainment and Mobile'),
                                ('HEALTH_CARE', 'Health-care and Wellbeing'),
                                ('E_COMMERCE', 'E-commerce, Adtech, Martech'),
                                ('MATERIALS', 'Manufacturing and materials'),
                                ('HARDWARE', 'Hardware & Iot'),
                                ('MOBILITY', 'Mobility & Transportation'),
                                ('ENERGY', 'Energy and Cleantech'),
                            ],
                            max_length=29,
                        ),
                        size=None,
                    ),
                ),
                (
                    'product_types',
                    django.contrib.postgres.fields.ArrayField(
                        base_field=models.CharField(
                            choices=[
                                ('SOFTWARE', 'Software'),
                                ('HARDWARE', 'Hardware'),
                                ('OTHER', 'Other'),
                            ],
                            max_length=8,
                        ),
                        size=None,
                    ),
                ),
                (
                    'investment_stage',
                    django.contrib.postgres.fields.ArrayField(
                        base_field=models.CharField(
                            choices=[
                                ('BUSINESS_ANGELS', 'Business Angels'),
                                ('INCUBATOR', 'Incubator'),
                                ('VENTURE_CAPITAL', 'Venture Capital'),
                                ('ACCELERATOR', 'Accelerator'),
                            ],
                            max_length=15,
                        ),
                        size=None,
                    ),
                ),
                ('is_product_on_market', models.BooleanField()),
                (
                    'business_type',
                    models.CharField(
                        choices=[
                            ('B2B', 'Business to Business'),
                            ('B2C', 'Business to Customer'),
                        ],
                        max_length=3,
                    ),
                ),
                (
                    'investment_size',
                    django.contrib.postgres.fields.ranges.IntegerRangeField(
                        validators=[
                            django.contrib.postgres.validators.RangeMinValueValidator(
                                0,
                            ),
                            django.contrib.postgres.validators.RangeMaxValueValidator(
                                2147483647,
                            ),
                        ],
                    ),
                ),
                ('avatar', models.ImageField(blank=True, upload_to='')),
            ],
            options={'abstract': False},
            bases=('profile.investorprofile', models.Model),
        ),
        migrations.CreateModel(
            name='Company',
            fields=[
                (
                    'investorprofile_ptr',
                    models.OneToOneField(
                        auto_created=True,
                        on_delete=django.db.models.deletion.CASCADE,
                        parent_link=True,
                        primary_key=True,
                        serialize=False,
                        to='profile.InvestorProfile',
                    ),
                ),
                ('website', models.URLField(blank=True)),
                (
                    'phone_number',
                    phonenumber_field.modelfields.PhoneNumberField(
                        max_length=128, region=None,
                    ),
                ),
                ('country', django_countries.fields.CountryField(max_length=2)),
                ('founding_date', models.DateField()),
                ('description', models.TextField(blank=True)),
                (
                    'stage',
                    models.CharField(
                        choices=[
                            ('CONCEPT_STAGE', 'Concept stage'),
                            ('GROWTH_STAGE', 'Growth stage (generating revenue)'),
                            ('EARLY_STAGE', 'Early stage (market launch)'),
                            ('SEED_STAGE', 'Seed stage (product development)'),
                        ],
                        max_length=33,
                    ),
                ),
                (
                    'sectors',
                    django.contrib.postgres.fields.ArrayField(
                        base_field=models.CharField(
                            choices=[
                                ('AI_AND_ROBOTICS', 'AI and robotics'),
                                ('IOT_AND_SENSORS', 'IoT and sensors'),
                                ('AGRICULTURE', 'Agriculture'),
                            ],
                            max_length=15,
                        ),
                        size=None,
                    ),
                ),
                (
                    'industries',
                    django.contrib.postgres.fields.ArrayField(
                        base_field=models.CharField(
                            choices=[
                                ('BUSINESS_ANALYTICS', 'Business & Analytics'),
                                (
                                    'FINANCIAL_SERVICES',
                                    'Financial Services & Security',
                                ),
                                ('ENTERTAINMENT', 'Entertainment and Mobile'),
                                ('HEALTH_CARE', 'Health-care and Wellbeing'),
                                ('E_COMMERCE', 'E-commerce, Adtech, Martech'),
                                ('MATERIALS', 'Manufacturing and materials'),
                                ('HARDWARE', 'Hardware & Iot'),
                                ('MOBILITY', 'Mobility & Transportation'),
                                ('ENERGY', 'Energy and Cleantech'),
                            ],
                            max_length=29,
                        ),
                        size=None,
                    ),
                ),
                (
                    'product_types',
                    django.contrib.postgres.fields.ArrayField(
                        base_field=models.CharField(
                            choices=[
                                ('SOFTWARE', 'Software'),
                                ('HARDWARE', 'Hardware'),
                                ('OTHER', 'Other'),
                            ],
                            max_length=8,
                        ),
                        size=None,
                    ),
                ),
                (
                    'investment_stage',
                    django.contrib.postgres.fields.ArrayField(
                        base_field=models.CharField(
                            choices=[
                                ('BUSINESS_ANGELS', 'Business Angels'),
                                ('INCUBATOR', 'Incubator'),
                                ('VENTURE_CAPITAL', 'Venture Capital'),
                                ('ACCELERATOR', 'Accelerator'),
                            ],
                            max_length=15,
                        ),
                        size=None,
                    ),
                ),
                ('is_product_on_market', models.BooleanField()),
                (
                    'business_type',
                    models.CharField(
                        choices=[
                            ('B2B', 'Business to Business'),
                            ('B2C', 'Business to Customer'),
                        ],
                        max_length=3,
                    ),
                ),
                (
                    'investment_size',
                    django.contrib.postgres.fields.ranges.IntegerRangeField(
                        validators=[
                            django.contrib.postgres.validators.RangeMinValueValidator(
                                0,
                            ),
                            django.contrib.postgres.validators.RangeMaxValueValidator(
                                2147483647,
                            ),
                        ],
                    ),
                ),
                ('name', models.CharField(max_length=255, unique=True)),
                ('email', models.EmailField(max_length=254, unique=True)),
                ('logotype', models.ImageField(blank=True, upload_to='')),
            ],
            options={'verbose_name_plural': 'Companies'},
            bases=('profile.investorprofile', models.Model),
        ),
        migrations.CreateModel(
            name='StartupToProfile',
            fields=[
                (
                    'id',
                    models.AutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name='ID',
                    ),
                ),
                (
                    'profile',
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name='+',
                        to='profile.Profile',
                    ),
                ),
                (
                    'startup',
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name='+',
                        to='profile.Startup',
                    ),
                ),
            ],
        ),
        migrations.AddField(
            model_name='startup',
            name='profiles',
            field=models.ManyToManyField(
                related_name='startups',
                through='profile.StartupToProfile',
                to='profile.Profile',
            ),
        ),
        migrations.CreateModel(
            name='CompanyToProfile',
            fields=[
                (
                    'id',
                    models.AutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name='ID',
                    ),
                ),
                (
                    'profile',
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name='+',
                        to='profile.Profile',
                    ),
                ),
            ],
        ),
        migrations.AddConstraint(
            model_name='startuptoprofile',
            constraint=models.UniqueConstraint(
                fields=('startup', 'profile'), name='startup_profile_unique',
            ),
        ),
        migrations.AddField(
            model_name='companytoprofile',
            name='company',
            field=models.ForeignKey(
                on_delete=django.db.models.deletion.CASCADE,
                related_name='+',
                to='profile.Company',
            ),
        ),
        migrations.AddField(
            model_name='company',
            name='profiles',
            field=models.ManyToManyField(
                related_name='companies',
                through='profile.CompanyToProfile',
                to='profile.Profile',
            ),
        ),
        migrations.AddField(
            model_name='angelinvestor',
            name='profile',
            field=models.OneToOneField(
                on_delete=django.db.models.deletion.CASCADE,
                related_name='angel_investor',
                to='profile.Profile',
            ),
        ),
        migrations.AddConstraint(
            model_name='companytoprofile',
            constraint=models.UniqueConstraint(
                fields=('company', 'profile'), name='company_profile_unique',
            ),
        ),
    ]
