# -*- coding: utf-8 -*-

from tests.factories import CompanyFactory


def test_company_string_representation():
    """Ensures that the company's name is its representation."""
    company = CompanyFactory.build()

    assert str(company) == company.name
