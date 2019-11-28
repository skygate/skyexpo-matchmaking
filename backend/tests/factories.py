# -*- coding: utf-8 -*-

import random
from functools import partial
from typing import List, Tuple

import factory.fuzzy  # noqa: WPS301
from factory import LazyFunction

from server.apps.company.constants import (
  CompanyStage,
  Industry,
  ProductType,
  Sector,
)
from server.apps.company.models import Company
from server.apps.profile.models import Profile, User


def get_multiple_choices(
    choices: List[Tuple[str, str]],
) -> List[str]:
    """Get a random number of choices from given list."""
    choices_len = random.randint(1, len(choices[0]))   # noqa: S311
    return [choice[0] for choice in choices[:choices_len]]


class CompanyFactory(factory.DjangoModelFactory):  # noqa: D101
    class Meta:
        model = Company

    name = factory.Faker('name')
    email = factory.Faker('safe_email')
    website = factory.Faker('uri')
    description = factory.Faker('sentence')
    founding_date = factory.Faker('date')
    phone_number = '+48 508223012'
    country = 'PL'
    logotype = factory.django.ImageField()
    founder_email = factory.Faker('safe_email')
    stage = factory.fuzzy.FuzzyChoice(
        choice[0] for choice in CompanyStage.CHOICES
    )
    sectors = LazyFunction(partial(get_multiple_choices, Sector.CHOICES))
    industries = LazyFunction(partial(get_multiple_choices, Industry.CHOICES))
    product_types = LazyFunction(
        partial(get_multiple_choices, ProductType.CHOICES),
    )
    min_investment_size = factory.fuzzy.FuzzyInteger(low=0)
    max_investment_size = factory.LazyAttribute(
        lambda company: company.min_investment_size + 100,
    )


class UserFactory(factory.DjangoModelFactory):  # noqa: D101
    class Meta:
        model = User

    email = factory.Faker('safe_email')
    is_staff = False
    is_active = True


class ProfileFactory(factory.DjangoModelFactory):  # noqa: D101
    class Meta:
        model = Profile

    user = factory.SubFactory(UserFactory)
    name = factory.Faker('name')
    company = factory.SubFactory(CompanyFactory)
