# -*- coding: utf-8 -*-

import pytest
from django.contrib.auth import get_user_model
from django.core.exceptions import ValidationError
from psycopg2._range import NumericRange  # noqa: WPS436

from server.apps.profile.models import Company, Profile
from tests.factories import (
  AngelInvestorFactory,
  CompanyFactory,
  StartupFactory,
)

User = get_user_model()


def test_profile_string_representation(user):
    """Ensures that Profile and User models representations are the same."""
    profile = Profile(user=user)

    assert str(profile) == str(user)


def test_startup_string_representation():
    """Ensures that the startup's name is its representation."""
    startup = StartupFactory.build()

    assert str(startup) == startup.name


def test_angel_investor_string_representation():
    """Ensures that the angel investor's email is its representation."""
    angel_investor = AngelInvestorFactory.build()

    assert str(angel_investor) == angel_investor.email


def test_company_string_representation():
    """Ensures that the company's name is its representation."""
    company = CompanyFactory.build()

    assert str(company) == company.name


@pytest.mark.django_db
def test_company_investment_size_constraint(company_data):
    """
    We represent the company's investment_size as IntegerRangeField so,
    there should be a constraint: where NumericRange(X, Y) => X < Y.
    """
    company_data['investment_size'] = NumericRange(2, 1)

    with pytest.raises(
        ValidationError,
        match='Maximum investment size should be lower or' +
            ' equal to minimum investment size.',
    ):
        Company(**company_data).full_clean()
