# -*- coding: utf-8 -*-

import pytest
from rest_framework import serializers

from server.apps.company.logic.serializers import (
  CompanyValidateFormStep1Serializer,
  CompanyValidateFormStep2Serializer,
  CompanyValidateFormStep3Serializer,
)
from server.apps.company.models import Company
from tests.factories import ProfileFactory


@pytest.mark.django_db
def test_register_company_validation_step1(
    django_assert_num_queries, company_step1_data,
):
    """
    Ensures that serializer returns proper fields
    and a number of queries are as expected.
    """
    serializer = CompanyValidateFormStep1Serializer(data=company_step1_data)

    with django_assert_num_queries(2):
        serializer.is_valid()

    assert set(serializer.data.keys()) == {
        'name',
        'email',
        'phone_number',
        'website',
        'country',
        'founding_date',
        'description',
        'logotype',
    }


@pytest.mark.django_db
def test_register_company_validate_email(company_data, company_step1_data):
    """Checks if a given email already exists in the db."""
    company = Company.objects.create(**company_data)

    company_step1_data['email'] = company.email

    with pytest.raises(
        serializers.ValidationError,
        match='Company with this e-mail already exists.',
    ):
        serializer = CompanyValidateFormStep1Serializer(data=company_step1_data)
        serializer.is_valid(raise_exception=True)


@pytest.mark.django_db
def test_register_company_validate_name(company_data, company_step1_data):
    """Checks if a company with the same name already exists in the db."""
    company = Company.objects.create(**company_data)

    company_step1_data['name'] = company.name

    with pytest.raises(
        serializers.ValidationError,
        match='Company with this name already exists.',
    ):
        serializer = CompanyValidateFormStep1Serializer(data=company_step1_data)
        serializer.is_valid(raise_exception=True)


@pytest.mark.django_db
def test_register_company_validation_step2(
    django_assert_num_queries, company_step2_data,
):
    """
    Ensures that serializer returns proper fields
    and a number of queries are as expected.
    """
    serializer = CompanyValidateFormStep2Serializer(data=company_step2_data)

    with django_assert_num_queries(len(company_step2_data['team_members']) + 1):
        serializer.is_valid()

    assert set(serializer.data.keys()) == {
        'founder_name',
        'founder_email',
        'team_members',
    }


@pytest.mark.django_db
def test_register_company_validate_founder_email(company_step2_data):
    """Checks if a given email already exists in the db."""
    profile = ProfileFactory.create()

    company_step2_data['founder_email'] = profile.user.email

    with pytest.raises(
        serializers.ValidationError,
        match=f'E-mail {profile.user.email} is already taken.',
    ):

        serializer = CompanyValidateFormStep2Serializer(data=company_step2_data)
        serializer.is_valid(raise_exception=True)


@pytest.mark.django_db
def test_register_company_validate_members_email(user, company_step2_data):
    """Checks if any member's email already exists in the db."""
    profile = ProfileFactory.create(user=user)
    company_step2_data['team_members'] = [
        {'name': profile.name, 'email': profile.user.email},
    ]

    with pytest.raises(
        serializers.ValidationError,
        match=f'E-mail {profile.user.email} is already taken.',
    ):
        serializer = CompanyValidateFormStep2Serializer(data=company_step2_data)
        serializer.is_valid(raise_exception=True)


@pytest.mark.django_db
def test_register_company_validate_founder_team(company_step2_data):
    """Ensures that 'founder_email' cannot be in 'team_members'."""
    founder_email = company_step2_data['founder_email']
    company_step2_data['team_members'] = [
        {'name': 'UserName1', 'email': founder_email},
    ]

    with pytest.raises(
        serializers.ValidationError,
        match=f"You can't enter the {founder_email} " +
        f'more than once.',
    ):
        serializer = CompanyValidateFormStep2Serializer(data=company_step2_data)
        serializer.is_valid(raise_exception=True)


@pytest.mark.django_db
def test_register_company_validation_step3(
    django_assert_num_queries, company_step3_data,
):
    """
    Ensures that serializer returns proper fields
    and a number of queries are as expected.
    """
    serializer = CompanyValidateFormStep3Serializer(data=company_step3_data)

    with django_assert_num_queries(0):
        serializer.is_valid()

    assert set(serializer.data.keys()) == {
        'industries',
        'sectors',
        'product_types',
        'company_stage',
        'investment_stage',
        'business_type',
        'is_product_on_market',
        'min_investment_size',
        'max_investment_size',
    }


@pytest.mark.django_db
def test_register_company_validate_investment(company_step3_data):
    """
    Ensures that 'max_investment_size' cannot be
    lower than 'min_investment_size'.
    """
    company_step3_data['min_investment_size'] = 1
    company_step3_data['max_investment_size'] = 0

    with pytest.raises(
        serializers.ValidationError,
        match='Maximum investment size should be lower or' +
        ' equal to minimum investment size.',
    ):
        serializer = CompanyValidateFormStep3Serializer(data=company_step3_data)
        serializer.is_valid(raise_exception=True)
