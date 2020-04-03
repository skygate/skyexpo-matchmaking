# -*- coding: utf-8 -*-

import random
from functools import partial
from typing import List, Tuple

import factory.fuzzy  # noqa: WPS301
from factory import LazyFunction
from psycopg2.extras import NumericRange

from server.apps.matchmaking.models import Match
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
  InvestorProfile,
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


class InvestorProfileFactory(factory.DjangoModelFactory):
    """Factory for InvestorProfile model."""

    class Meta:
        model = InvestorProfile


class CompanyFactory(
    BaseInfoFactory,
    BaseMatchmakingInfoFactory,
    InvestorProfileFactory,
):
    """Factory for Company model."""

    class Meta:
        model = Company

    name = factory.Faker('name')
    email = factory.Faker('safe_email')
    logotype = factory.django.ImageField()

    @factory.post_generation
    def profiles(self, create, profiles):
        if not create:
            return

        if profiles:
            for profile in profiles:
                self.profiles.add(profile)


class StartupFactory(
    factory.DjangoModelFactory, BaseInfoFactory, BaseMatchmakingInfoFactory,
):
    """Factory for Startup model."""

    class Meta:
        model = Startup

    name = factory.Faker('name')
    email = factory.Faker('safe_email')
    logotype = factory.django.ImageField()

    @factory.post_generation
    def profiles(self, create, profiles):
        if not create:
            return

        if profiles:
            for profile in profiles:
                self.profiles.add(profile)


class AngelInvestorFactory(
    BaseInfoFactory,
    BaseMatchmakingInfoFactory,
    InvestorProfileFactory,
):
    """Factory for AngelInvestor model."""

    class Meta:
        model = AngelInvestor

    avatar = factory.django.ImageField()
    profile = factory.SubFactory('tests.factories.ProfileFactory')


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


class MatchFactory(factory.DjangoModelFactory):
    """
    Factory for Match model.
    If you want to add investor to this factory, you have to set him explicitly,
    e.g: MatchFactory.create(investor=AngelInvestorFactory.create())
    """

    class Meta:
        model = Match

    startup = factory.SubFactory(StartupFactory)
    result = factory.fuzzy.FuzzyInteger(0, 100)
