# -*- coding: utf-8 -*-

from django.contrib.auth.base_user import AbstractBaseUser
from django.contrib.auth.models import PermissionsMixin
from django.contrib.postgres.fields import ArrayField, IntegerRangeField
from django.contrib.postgres.validators import RangeMinValueValidator
from django.db import models
from django.utils import timezone
from django_countries.fields import CountryField
from phonenumber_field.modelfields import PhoneNumberField

from server.apps.profile.constants import CompanyStage, Industry, Sector, ProductType, InvestmentStage, BusinessType
from server.apps.profile.logic.managers import UserManager
from server.apps.profile.logic.querysets import ProfileQuerySet


class BaseInfo(models.Model):
    """
    Every active profile has to belong to Startup, Company or be AngelInvestor.
    We group their common fields in this model.
    """

    email = models.EmailField(unique=True)
    website = models.URLField(blank=True)
    phone_number = PhoneNumberField()
    country = CountryField()
    founding_date = models.DateField()
    description = models.CharField(max_length=255, blank=True)

    class Meta:
        abstract = True


class BaseMatchmakingInfo(models.Model):
    """
    Angel investors, startup and company members take part in matchmaking.
    Our algorithms match pairs mainly on the basis of these fields.
    """

    stage = models.CharField(choices=CompanyStage.CHOICES, max_length=33)
    sectors = ArrayField(
        models.CharField(choices=Sector.CHOICES, max_length=15),
    )
    industries = ArrayField(
        models.CharField(choices=Industry.CHOICES, max_length=29),
    )
    product_types = ArrayField(
        models.CharField(choices=ProductType.CHOICES, max_length=8),
    )
    investment_stage = ArrayField(
        models.CharField(choices=InvestmentStage.CHOICES, max_length=15),
    )
    is_product_on_market = models.BooleanField()
    investment_size = IntegerRangeField(validators=[RangeMinValueValidator(0)])
    business_type = models.CharField(choices=BusinessType.CHOICES, max_length=3)

    class Meta:
        abstract = True


class Company(BaseInfo, BaseMatchmakingInfo):
    """Represents a company that want investing e.g an investment fund."""

    name = models.CharField(max_length=255, unique=True)
    # TODO: set 'default' attr on ImageField when I get the default logotype.
    logotype = models.ImageField(blank=True)

    class Meta:
        verbose_name_plural = 'Companies'

    def __str__(self) -> str:
        return self.name


class Startup(BaseInfo, BaseMatchmakingInfo):
    """Represents a startup that is looking for investors."""

    name = models.CharField(max_length=255, unique=True)
    # TODO: set 'default' attr on ImageField when I get the default logotype.
    logotype = models.ImageField(blank=True)

    def __str__(self) -> str:
        return self.name


class AngelInvestor(BaseInfo, BaseMatchmakingInfo):
    """Represents an individual who provides financial backing for startups."""

    name = models.CharField(max_length=255)
    # TODO: set 'default' attr on ImageField when I get the default avatar.
    avatar = models.ImageField(blank=True)

    def __str__(self) -> str:
        return self.email


class User(AbstractBaseUser, PermissionsMixin):
    """The Custom user model used only for authentication purposes."""

    email = models.EmailField(unique=True, db_index=True)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)

    USERNAME_FIELD = 'email'  # noqa: WPS115

    objects = UserManager()


class Profile(models.Model):
    """Represents the user's profile."""

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=255)
    date_joined = models.DateTimeField(default=timezone.now)
    company = models.ForeignKey(
        Company,
        on_delete=models.SET_NULL,
        db_index=True,
        null=True,
        blank=True,
        related_name='profiles',
        default=None,
    )
    startup = models.ForeignKey(
        Startup,
        on_delete=models.SET_NULL,
        db_index=True,
        null=True,
        blank=True,
        related_name='profiles',
        default=None,
    )
    angel_investor = models.OneToOneField(
        AngelInvestor,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='profile',
        default=None,
    )

    objects = ProfileQuerySet.as_manager()

    class Meta:
        constraints = [
            models.CheckConstraint(
                check=~models.Q(name=''), name='non_empty_name',
            ),
        ]

    def __str__(self) -> str:
        return str(self.user)
