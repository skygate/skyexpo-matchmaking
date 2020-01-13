# -*- coding: utf-8 -*-

from dataclasses import asdict
from typing import Any, Dict, List

from django.contrib.auth import get_user_model
from django.core.exceptions import ValidationError
from django.db import transaction
from django.utils.translation import ugettext_lazy as ugt
from glom import glom
from psycopg2.extras import NumericRange

from server.apps.profile.logic.representations import (
  AngelInvestorRepresentation,
  CompanyRepresentation,
  StartupRepresentation,
  TeamMembersRepresentation,
)
from server.apps.profile.models import (
  AngelInvestor,
  BaseMatchmakingInfo,
  Company,
  CompanyToProfile,
  Profile,
  Startup,
  StartupToProfile,
)

User = get_user_model()


def check_for_duplicated_emails(*, emails: List[str]) -> None:
    """Check if emails are duplicated in team members input."""
    if len(emails) != len(set(emails)):
        raise ValidationError(
            {'team_members': ugt('You cannot enter the same email twice.')},
        )


def validate_company_form_step1(data: Dict[str, Any]) -> None:
    """Run validation for company registering form step 1."""
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


def validate_team_members_form(
    *, team_members: TeamMembersRepresentation,
) -> None:
    """Run validation for company's/startup's team members form"""
    emails = glom(team_members.team_members, ['email'])
    check_for_duplicated_emails(emails=emails)
    for email in emails:
        try:
            profile = Profile.objects.get(user__email=email)
        except Profile.DoesNotExist:
            continue
        else:
            if profile not in Profile.objects.unassigned_profiles():
                raise ValidationError(
                    {'team_members': ugt(f'{email} is already assigned.')},
                )


def validate_matchmaking_form(data: Dict[str, Any]) -> None:
    """Run validation for matchmaking fields in registering form step 3."""
    min_investment = data.pop('min_investment_size')
    max_investment = data.pop('max_investment_size')

    investment_size = NumericRange(min_investment, max_investment)
    match_info = BaseMatchmakingInfo(**data, investment_size=investment_size)

    match_info.full_clean()


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
def create_inactive_profile(*, email: str, name: str) -> Profile:
    """
    Creates inactive profile. User has to sign up, assign password
    and then we can activate profile.
    """
    user_instance = User(email=email, is_active=False)
    user_instance.full_clean(exclude=['password'])
    user_instance.save()

    profile_instance = Profile(user=user_instance, name=name)

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
                email=team_member['email'],
                name=team_member['name'],
            )
        profiles.append(profile)

    return profiles


def assign_profiles_to_company(
    *, profiles: List[Profile], company: Company,
) -> None:
    """Links specific profiles with a company."""
    for profile in profiles:
        assign_profile_to_company(profile=profile, company=company)


def validate_startup_form_step1(data: Dict[str, Any]) -> None:
    """Run validation for startup registering form step 1."""
    startup = Startup(**data)
    startup.full_clean(
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


def validate_angel_investor_form_step1(data: Dict[str, Any]) -> None:
    """Run validation for AngelInvestor registering form step 1."""
    data.pop('name')
    data.pop('email')
    investor = AngelInvestor(**data)

    exclude = [
        'industries',
        'sectors',
        'product_types',
        'stage',
        'investment_stage',
        'investment_size',
        'is_product_on_market',
        'business_type',
        'profile',
    ]
    investor.clean_fields(exclude=exclude)
    investor.validate_unique(exclude=exclude)


def assign_profile_to_startup(*, profile: Profile, startup: Startup) -> Profile:
    """Add existing profile to startup."""
    relation = StartupToProfile(profile=profile, startup=startup)
    relation.full_clean()
    relation.save()

    return relation.profile


def assign_profiles_to_startup(
    *, profiles: List[Profile], startup: Startup,
) -> None:
    """Links specific profiles with a startup."""
    for profile in profiles:
        assign_profile_to_startup(profile=profile, startup=startup)


def create_startup(*, startup: StartupRepresentation) -> Startup:
    """Creates startup."""
    startup_data = asdict(startup)
    investment_size = NumericRange(
        lower=startup_data.pop('min_investment_size'),
        upper=startup_data.pop('max_investment_size'),
    )

    startup_instance = Startup(**startup_data, investment_size=investment_size)
    startup_instance.full_clean()
    startup_instance.save()

    return startup_instance


@transaction.atomic()
def create_angel_investor(
    *, angel_investor: AngelInvestorRepresentation,
) -> AngelInvestor:
    """Creates AngelInvestor."""
    investor_data = asdict(angel_investor)
    investment_size = NumericRange(
        lower=investor_data.pop('min_investment_size'),
        upper=investor_data.pop('max_investment_size'),
    )

    profile = create_inactive_profile(
        email=investor_data.pop('email'),
        name=investor_data.pop('name'),
    )

    investor_instance = AngelInvestor(
        **investor_data,
        investment_size=investment_size,
        profile=profile,
    )

    investor_instance.full_clean()
    investor_instance.save()

    return investor_instance
