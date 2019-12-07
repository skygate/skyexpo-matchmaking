# -*- coding: utf-8 -*-

import random
from functools import partial
from typing import List, Tuple

import factory.fuzzy  # noqa: WPS301
from factory import LazyFunction
from psycopg2.extras import NumericRange

from server.apps.profile.constants import (
  BusinessType,
  CompanyStage,
  Industry,
  InvestmentStage,
  ProductType,
  Sector,
)
from server.apps.profile.models import (
  MAX_INTEGER_FIELD_VALUE,
  MIN_INVESTMENT_VALUE,
  AngelInvestor,
  Company,
  Profile,
  Startup,
  User,
)


def get_multiple_choices(
    choices: List[Tuple[str, str]],
) -> List[str]:
    """Get a random number of choices from given list."""
    choices_len = random.randint(1, len(choices[0]))   # noqa: S311
    return [choice[0] for choice in choices[:choices_len]]


class BaseInfoFactory(factory.Factory):
    """Factory for BaseInfo model."""

    email = factory.Faker('safe_email')
    website = factory.Faker('uri')
    phone_number = '+48 508223012'
    country = 'PL'
    founding_date = factory.Faker('date')
    description = factory.Faker('sentence')

    class Meta:
        abstract = True


class BaseMatchmakingInfoFactory(factory.Factory):
    """Factory for BaseMatchemakingInfo model."""

    stage = factory.fuzzy.FuzzyChoice(
        choice[0] for choice in CompanyStage.CHOICES
    )
    sectors = LazyFunction(partial(get_multiple_choices, Sector.CHOICES))
    industries = LazyFunction(partial(get_multiple_choices, Industry.CHOICES))
    product_types = LazyFunction(
        partial(get_multiple_choices, ProductType.CHOICES),
    )
    investment_stage = LazyFunction(
        partial(get_multiple_choices, InvestmentStage.CHOICES),
    )
    investment_size = NumericRange(
        MIN_INVESTMENT_VALUE, MAX_INTEGER_FIELD_VALUE,
    )
    is_product_on_market = True
    business_type = factory.fuzzy.FuzzyChoice(
        choice[0] for choice in BusinessType.CHOICES
    )

    class Meta:
        abstract = True


class CompanyFactory(BaseInfoFactory, BaseMatchmakingInfoFactory):
    """Factory for Company model."""

    class Meta:
        model = Company

    name = factory.Faker('name')
    logotype = factory.django.ImageField()


class StartupFactory(BaseInfoFactory, BaseMatchmakingInfoFactory):
    """Factory for Startup model."""

    class Meta:
        model = Startup

    name = factory.Faker('name')
    logotype = factory.django.ImageField()


class AngelInvestorFactory(BaseInfoFactory, BaseMatchmakingInfoFactory):
    """Factory for AngelInvestor model."""

    class Meta:
        model = AngelInvestor

    name = factory.Faker('name')
    avatar = factory.django.ImageField()


class UserFactory(factory.DjangoModelFactory):
    """Factory for User model."""

    class Meta:
        model = User

    email = factory.Faker('safe_email')
    is_staff = False
    is_active = True


class ProfileFactory(factory.DjangoModelFactory):
    """Factory for Profile model."""

    class Meta:
        model = Profile

    user = factory.SubFactory(UserFactory)
    name = factory.Faker('name')
