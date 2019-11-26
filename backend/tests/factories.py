# -*- coding: utf-8 -*-

import factory.fuzzy  # noqa: WPS301

from server.apps.company.constants import CompanyStage
from server.apps.company.models import Company


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
    stage = factory.fuzzy.FuzzyChoice(
        choice[0] for choice in CompanyStage.CHOICES
    )
    sectors = []
    industries = []
    product_types = []
