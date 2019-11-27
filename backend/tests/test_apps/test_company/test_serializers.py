# -*- coding: utf-8 -*-

import pytest
from rest_framework import serializers

from server.apps.company.logic.serializers import (
  CompanyValidateFormStep1Serializer,
)
from server.apps.company.models import Company


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
