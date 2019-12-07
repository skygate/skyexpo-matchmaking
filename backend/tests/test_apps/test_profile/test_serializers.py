# -*- coding: utf-8 -*-

from server.apps.profile.logic.serializers import (
  CompanyValidateFormStep1Serializer,
  CompanyValidateFormStep2Serializer,
  CompanyValidateFormStep3Serializer,
)


def test_register_company_validation_step1(company_step1_data):
    """Ensures that serializer returns proper fields."""
    serializer = CompanyValidateFormStep1Serializer(data=company_step1_data)

    serializer.is_valid(raise_exception=True)

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


def test_register_company_validation_step2(company_step2_data):
    """Ensures that serializer returns proper fields."""
    serializer = CompanyValidateFormStep2Serializer(data=company_step2_data)

    serializer.is_valid(raise_exception=True)

    assert set(serializer.data.keys()) == {
        'team_members',
    }


def test_register_company_validation_step3(company_step3_data):
    """Ensures that serializer returns proper fields."""
    serializer = CompanyValidateFormStep3Serializer(data=company_step3_data)

    serializer.is_valid(raise_exception=True)

    assert set(serializer.data.keys()) == {
        'industries',
        'sectors',
        'product_types',
        'stage',
        'investment_stage',
        'business_type',
        'is_product_on_market',
        'min_investment_size',
        'max_investment_size',
    }
