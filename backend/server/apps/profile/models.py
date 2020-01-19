# -*- coding: utf-8 -*-

from typing import Union

from django.contrib.auth.base_user import AbstractBaseUser
from django.contrib.auth.models import PermissionsMixin
from django.contrib.postgres import fields, validators
from django.core.exceptions import ValidationError
from django.db import models
from django.utils import timezone
from django.utils.translation import ugettext_lazy as ugtl
from django_countries.fields import CountryField
from phonenumber_field.modelfields import PhoneNumberField

from server.apps.profile import constants
from server.apps.profile.constants import (
  MAX_INTEGER_FIELD_VALUE,
  MIN_INVESTMENT_VALUE,
)
from server.apps.profile.logic import managers, querysets


def validate_profile_is_unassigned(*, profile: 'Profile', msg: str) -> None:
    """Raise error if profile is already assigned."""
    if profile not in Profile.objects.unassigned_profiles():
        raise ValidationError({'profile': msg})


class User(AbstractBaseUser, PermissionsMixin):
    """The Custom user model used only for authentication purposes."""

    email = models.EmailField(unique=True, db_index=True)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)

    USERNAME_FIELD = 'email'  # noqa: WPS115

    objects = managers.UserManager.from_queryset(querysets.UserQuerySet)()


class BaseInfo(models.Model):
    """
    Every active profile has to belong to Startup, Company or be AngelInvestor.
    We group their common fields in this model.
    """

    website = models.URLField(blank=True)
    phone_number = PhoneNumberField()
    country = CountryField()
    founding_date = models.DateField()
    description = models.TextField(blank=True)

    class Meta:
        abstract = True


class BaseMatchmakingInfo(models.Model):
    """
    Angel investors, startup and company members take part in matchmaking.
    Our algorithms match pairs mainly on the basis of these fields.
    """

    stage = models.CharField(
        choices=constants.CompanyStage.CHOICES, max_length=33,
    )
    sectors = fields.ArrayField(
        models.CharField(choices=constants.Sector.CHOICES, max_length=15),
    )
    industries = fields.ArrayField(
        models.CharField(choices=constants.Industry.CHOICES, max_length=29),
    )
    product_types = fields.ArrayField(
        models.CharField(choices=constants.ProductType.CHOICES, max_length=8),
    )
    investment_stage = fields.ArrayField(
        models.CharField(
            choices=constants.InvestmentStage.CHOICES, max_length=15,
        ),
    )
    is_product_on_market = models.BooleanField()
    business_type = models.CharField(
        choices=constants.BusinessType.CHOICES, max_length=3,
    )
    investment_size = fields.IntegerRangeField(
        validators=[
            validators.RangeMinValueValidator(MIN_INVESTMENT_VALUE),
            validators.RangeMaxValueValidator(MAX_INTEGER_FIELD_VALUE),
        ],
    )

    def clean_fields(self, exclude=None) -> None:
        super().clean_fields(exclude=exclude)
        if exclude and 'investment_size' in exclude:
            return

        if self.investment_size.lower > self.investment_size.upper:
            raise ValidationError({
                'investment_size': ugtl(
                    'Maximum investment size should be lower or ' +
                    'equal to minimum investment size.',
                ),
            })

    class Meta:
        abstract = True


class InvestorProfile(models.Model):
    """Marks model as investor."""

    def get_child(self) -> Union['Company', 'AngelInvestor']:
        try:
            return self.company
        except AttributeError:
            return self.angelinvestor

    def __str__(self) -> str:
        return str(self.get_child())


class Profile(models.Model):
    """Represents the user's profile."""

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=255)
    date_joined = models.DateTimeField(default=timezone.now)

    objects = querysets.ProfileQuerySet.as_manager()

    def __str__(self) -> str:
        return str(self.user)


class AngelInvestor(BaseInfo, BaseMatchmakingInfo, InvestorProfile):
    """Represents an individual who provides financial backing for startups."""

    # TODO: set 'default' attr on ImageField when I get the default avatar.
    avatar = models.ImageField(blank=True)
    profile = models.OneToOneField(
        Profile, on_delete=models.CASCADE, related_name='angel_investor',
    )

    def clean(self):
        validate_profile_is_unassigned(
            profile=self.profile, msg=ugtl('This profile is already assigned.'),
        )

    def __str__(self) -> str:
        return self.profile.user.email


class Startup(BaseInfo, BaseMatchmakingInfo):
    """Represents a startup that is looking for investors."""

    name = models.CharField(max_length=255, unique=True)
    email = models.EmailField(unique=True)
    # TODO: set 'default' attr on ImageField when I get the default logotype.
    logotype = models.ImageField(blank=True)
    profiles = models.ManyToManyField(
        Profile, through='StartupToProfile', related_name='startups',
    )

    def __str__(self) -> str:
        return self.name

    def get_profiles(self) -> 'models.QuerySet[Profile]':
        return Profile.objects.filter(startups=self.pk).select_related('user')


class StartupToProfile(models.Model):
    """M2M intermediary join table to represent startup-profiles relation."""

    startup = models.ForeignKey(
        Startup, on_delete=models.CASCADE, related_name='+',
    )
    profile = models.ForeignKey(
        Profile, on_delete=models.CASCADE, related_name='+',
    )

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=('startup', 'profile'), name='startup_profile_unique',
            ),
        ]

    def clean(self):
        validate_profile_is_unassigned(
            profile=self.profile, msg=ugtl('This profile is already assigned.'),
        )

    def __str__(self) -> str:
        return f'{str(self.profile)} - {str(self.startup)}'


class Company(BaseInfo, BaseMatchmakingInfo, InvestorProfile):
    """Represents a company that want investing e.g an investment fund."""

    name = models.CharField(max_length=255, unique=True)
    email = models.EmailField(unique=True)
    # TODO: set 'default' attr on ImageField when I get the default logotype.
    logotype = models.ImageField(blank=True)
    profiles = models.ManyToManyField(
        Profile, through='CompanyToProfile', related_name='companies',
    )

    class Meta:
        verbose_name_plural = 'Companies'

    def __str__(self) -> str:
        return self.name

    def get_profiles(self) -> 'models.QuerySet[Profile]':
        return Profile.objects.filter(companies=self.pk).select_related('user')


class CompanyToProfile(models.Model):
    """M2M intermediary join table to represent company-profiles relation."""

    company = models.ForeignKey(
        Company, on_delete=models.CASCADE, related_name='+',
    )
    profile = models.ForeignKey(
        Profile, on_delete=models.CASCADE, related_name='+',
    )

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=('company', 'profile'), name='company_profile_unique',
            ),
        ]

    def clean(self):
        validate_profile_is_unassigned(
            profile=self.profile, msg=ugtl('This profile is already assigned.'),
        )

    def __str__(self) -> str:
        return f'{str(self.profile)} - {str(self.company)}'
