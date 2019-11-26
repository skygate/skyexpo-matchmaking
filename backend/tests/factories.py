# -*- coding: utf-8 -*-

import factory

from server.apps.company.models import Company


class CompanyFactory(factory.DjangoModelFactory):  # noqa: D101
    class Meta:
        model = Company

    email = factory.Faker('safe_email')
