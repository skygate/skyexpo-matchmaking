# -*- coding: utf-8 -*-

from typing import Any, Dict, List

from django.core.exceptions import ValidationError
from psycopg2._range import NumericRange  # noqa: WPS436

from server.apps.profile.models import Company


def check_for_duplicated_emails(*, emails: List[str]) -> None:
    """Check if emails are duplicated in team members input."""
    if len(emails) != len(set(emails)):
        raise ValidationError(
            {'team_members': 'You cannot enter the same email twice.'},
        )


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
