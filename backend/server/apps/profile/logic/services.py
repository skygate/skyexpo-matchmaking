# -*- coding: utf-8 -*-

from dataclasses import asdict
from typing import Any, Dict, List, Optional

from django.contrib.auth import get_user_model
from django.core.exceptions import ValidationError
from django.db import transaction
from django.utils.translation import ugettext_lazy as ugt
from glom import glom
from psycopg2.extras import NumericRange

from server.apps.profile.logic.representations import (
  CompanyRepresentation,
  ProfileRepresentation,
  TeamMembersRepresentation,
  UserRepresentation,
)
from server.apps.profile.models import Company, Profile, CompanyToProfile

User = get_user_model()


def check_for_duplicated_emails(*, emails: List[str]) -> None:
    """Check if emails are duplicated in team members input."""
    if len(emails) != len(set(emails)):
        raise ValidationError(
            {'team_members': ugt('You cannot enter the same email twice.')},
        )


def validate_company_form_step1(data: Dict[str, Any]) -> None:
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


def validate_company_form_step2(data: Dict[str, Any]) -> None:
    """Run validation for company registering form step 1."""
    emails = glom(data, ('team_members', ['email']))
    check_for_duplicated_emails(emails=emails)


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


def create_company(*, company: CompanyRepresentation) -> Company:
    """Creates company."""
    company_data = asdict(company)
    investment_size = NumericRange(
        lower=company_data.pop('min_investment_size'),
        upper=company_data.pop('max_investment_size'),
    )

    company_instance = Company(**company_data, investment_size=investment_size)
    company_instance.full_clean()
    company_instance.save()

    return company_instance


@transaction.atomic()
def create_inactive_profile(
    *, user: UserRepresentation, profile: ProfileRepresentation,
) -> Profile:
    """
    Creates inactive profile. User has to sign up, assign password
    and then we can activate profile.
    """
    user.is_active = False
    user_instance = User(**asdict(user))
    user_instance.full_clean(exclude=['password'])
    user_instance.save()

    profile_instance = Profile(user=user_instance, **asdict(profile))

    profile_instance.full_clean()
    profile_instance.save()

    return profile_instance


def assign_profile_to_company(*, profile: Profile, company: Company) -> Profile:
    """Add existing profile to company."""
    relation = CompanyToProfile(profile=profile, company=company)
    relation.full_clean()
    relation.save()

    return relation.profile


def create_team_members_profiles(
    *, team_members: TeamMembersRepresentation,
) -> List[Profile]:
    """Creates inactive profiles if needed."""
    profiles = []
    for team_member in asdict(team_members)['team_members']:
        try:
            profile = Profile.objects.get(user__email=team_member['email'])
        except Profile.DoesNotExist:
            profile = create_inactive_profile(
                user=UserRepresentation(email=team_member['email']),
                profile=ProfileRepresentation(
                    name=team_member['name']
                ),
            )
        profiles.append(profile)

    return profiles


def assign_profiles_to_company(
    *, profiles: List[Profile], company: Company
) -> None:
    """Links specific profiles with a company."""
    for profile in profiles:
        assign_profile_to_company(profile=profile, company=company)
