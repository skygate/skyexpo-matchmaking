# -*- coding: utf-8 -*-

from unittest.mock import patch

import pytest
from django.contrib.auth import get_user_model
from django.core.exceptions import ValidationError
from psycopg2.extras import NumericRange

from server.apps.profile.models import (
  Company,
  CompanyToProfile,
  Profile,
  StartupToProfile,
  validate_profile_is_unassigned,
)
from tests.factories import (
  AngelInvestorFactory,
  CompanyFactory,
  ProfileFactory,
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


def test_startup_to_profile_string_representation():
    """Ensures that str(StartupToProfile) == str(profile) - str(startup)"""
    startup = StartupFactory.build()
    profile = ProfileFactory.build()
    startup_to_profile = StartupToProfile(startup=startup, profile=profile)

    expected_str_repr = f'{str(profile)} - {str(startup)}'
    assert str(startup_to_profile) == expected_str_repr


def test_company_to_profile_string_representation():
    """Ensures that str(StartupToProfile) == str(profile) - str(company)"""
    company = CompanyFactory.build()
    profile = ProfileFactory.build()
    company_to_profile = CompanyToProfile(company=company, profile=profile)

    expected_str_repr = f'{str(profile)} - {str(company)}'
    assert str(company_to_profile) == expected_str_repr


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


@pytest.mark.django_db
def test_validate_profile_is_unassigned(company):
    """
    This function should raise an error if specified profile is not
    unassigned_profiles.
    """
    profile = ProfileFactory.create()
    msg = 'test message'

    assert validate_profile_is_unassigned(profile=profile, msg=msg) is None

    assigned_profile = ProfileFactory.create()
    CompanyToProfile.objects.create(profile=assigned_profile, company=company)

    with pytest.raises(
        ValidationError,
        match=msg,
    ):
        validate_profile_is_unassigned(profile=assigned_profile, msg=msg)


@pytest.mark.django_db
@patch('server.apps.profile.models.validate_profile_is_unassigned')
def test_angel_investor_clean(validate_profile_is_unassigned_mock):
    """Angelinvestor should call 'validate_profile_is_unassigned' in 'clean'."""
    profile = ProfileFactory.create()
    angel_investor = AngelInvestorFactory.build(profile=profile)

    angel_investor.clean()
    validate_profile_is_unassigned_mock.assert_called()


@pytest.mark.django_db
@patch('server.apps.profile.models.validate_profile_is_unassigned')
def test_startup_to_profile_clean(validate_profile_is_unassigned_mock):
    """
    M2M relation between startup and profile should call
    'validate_profile_is_unassigned' in 'clean'.
    """
    startup = StartupFactory.create()
    profile = ProfileFactory.create()
    startup_to_profile = StartupToProfile(startup=startup, profile=profile)

    startup_to_profile.clean()
    validate_profile_is_unassigned_mock.assert_called()


@pytest.mark.django_db
@patch('server.apps.profile.models.validate_profile_is_unassigned')
def test_company_to_profile_clean(validate_profile_is_unassigned_mock):
    """
    M2M relation between company and profile should call
    'validate_profile_is_unassigned' in 'clean'.
    """
    company = CompanyFactory.create()
    profile = ProfileFactory.create()
    company_to_profile = CompanyToProfile(company=company, profile=profile)

    company_to_profile.clean()
    validate_profile_is_unassigned_mock.assert_called()
