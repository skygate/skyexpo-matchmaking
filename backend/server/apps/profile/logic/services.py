# -*- coding: utf-8 -*-
from dataclasses import asdict
from typing import Any, Dict, List

from django.core.exceptions import ValidationError
from django.db import transaction
from glom import glom
from psycopg2.extras import NumericRange

from server.apps.profile.logic.representations import CompanyRepresentation
from server.apps.profile.models import Company


def check_for_duplicated_emails(*, emails: List[str]) -> None:
    """Check if emails are duplicated in team members input."""
    if len(emails) != len(set(emails)):
        raise ValidationError(
            {'team_members': 'You cannot enter the same email twice.'},
        )


def validate_company_form_step1(data: Dict[str, Any]) -> None:
    """Run validation for company registering form step 1."""
    emails = glom(data, ('team_members', ['email']))
    check_for_duplicated_emails(emails=emails)


def validate_company_form_step2(data: Dict[str, Any]) -> None:
    """Run validation for company registering form step 2."""
    company = Company(**data)
    company.full_clean(
        exclude=[
            'industries',
            'sectors',
            'product_types',
            'stage',
            'investment_stage',
            'investment_size',
            'is_product_on_market',
            'business_type',
        ],
    )


def validate_company_form_step3(data: Dict[str, Any]) -> None:
    """Run validation for company registering form step 3."""
    min_investment = data.pop('min_investment_size')
    max_investment = data.pop('max_investment_size')

    investment_size = NumericRange(min_investment, max_investment)
    company = Company(**data, investment_size=investment_size)

    company.full_clean(
        exclude=[
            'name',
            'email',
            'website',
            'phone_number',
            'country',
            'founding_date',
            'description',
            'logotype',
        ],
    )


@transaction.atomic()
def create_company(*, company: CompanyRepresentation) -> Company:
    """Service that creates company."""

    company_data = asdict(company)
    team_members = company_data.pop('team_members')

    investment_size = NumericRange(
        lower=company_data.pop('min_investment_size'),
        upper=company_data.pop('max_investment_size'),
    )

    company_instance = Company(**company_data, investment_size=investment_size)
    company_instance.full_clean()
    company_instance.save()

    return company_instance
