# -*- coding: utf-8 -*-

from django.contrib.postgres.fields import ArrayField
from django.db import models
from django_countries.fields import CountryField
from phonenumber_field.modelfields import PhoneNumberField

from server.apps.company.constants import (
  CompanyStage,
  Industry,
  ProductType,
  Sector,
)


class Company(models.Model):
    """Represents a company that is looking for investors."""

    name = models.CharField(max_length=120, unique=True)
    email = models.EmailField(unique=True)
    website = models.URLField(blank=True)
    phone_number = PhoneNumberField()
    country = CountryField()
    founding_date = models.DateField()
    description = models.CharField(max_length=255, blank=True)
    # TODO: set 'default' attr on ImageField when I get the default logotype.
    logotype = models.ImageField(blank=True)
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

    class Meta:
        verbose_name_plural = 'Companies'

    def __str__(self) -> str:
        return self.name

    def save(self, **kwargs):
        self.full_clean()
        return super().save(**kwargs)
