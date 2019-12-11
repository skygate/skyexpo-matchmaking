# -*- coding: utf-8 -*-

import pytest
from django.core.exceptions import ValidationError

from server.apps.profile.logic.representations import (
  CompanyRepresentation,
  ProfileRepresentation,
  TeamMembersRepresentation,
  UserRepresentation,
)
from server.apps.profile.logic.services import (
  assign_profile_to_company,
  assign_profiles_to_company,
  check_for_duplicated_emails,
  create_company,
  create_inactive_profile,
  create_team_members_profiles,
  validate_company_form_step2,
)
from server.apps.profile.models import Company, Profile
from tests.factories import ProfileFactory


def test_check_for_duplicated_emails():
    """Ensures that function checks for duplicates correctly."""
    emails = ['marcin@jos.pl', 'marcin@jos.pl']

    with pytest.raises(
        ValidationError, match='You cannot enter the same email twice.',
    ):
        check_for_duplicated_emails(emails=emails)


@pytest.mark.django_db
def test_validate_company_form_step2(company):
    """Checks if profiles are already assigned."""
    profile1 = ProfileFactory.create()
    profile2 = ProfileFactory.create()
    assign_profile_to_company(profile=profile1, company=company)
    team_members_repr = TeamMembersRepresentation(
        team_members=[
            {'name': profile2.name, 'email': profile2.user.email},
            {'name': profile1.name, 'email': profile1.user.email},
        ],
    )

    with pytest.raises(
        ValidationError, match=f'{profile1.user.email} is already assigned.',
    ):
        validate_company_form_step2(team_members=team_members_repr)


@pytest.mark.django_db
def test_create_company(company_data):
    """Ensures function creates company from CompanyRepresentation correctly."""
    company_data.pop('investment_size')
    company_repr = CompanyRepresentation(
        **company_data, min_investment_size=1, max_investment_size=2,
    )

    company = create_company(company=company_repr)

    assert Company.objects.count() == 1
    assert list(Company.objects.all()) == [company]


@pytest.mark.django_db
def test_create_inactive_profile():
    """Creates inactive profile from given User and Profile representations."""
    user_repr = UserRepresentation(email='test@email.com')
    profile_repr = ProfileRepresentation(name='Marcin')

    inactive_profile = create_inactive_profile(
        user=user_repr, profile=profile_repr,
    )

    assert Profile.objects.count() == 1
    assert list(Profile.objects.all()) == [inactive_profile]
    assert inactive_profile.user.is_active is False


@pytest.mark.django_db
def test_assign_profile_to_company(company):
    """Assigns existing profile to existing company."""
    profile = ProfileFactory.create()

    assigned_profile = assign_profile_to_company(
        profile=profile, company=company,
    )

    assert assigned_profile.companies.first() == company


@pytest.mark.django_db
def test_assign_profiles_to_company(company):
    """Assigns many profiles to one company."""
    profiles = [ProfileFactory.create(), ProfileFactory.create()]

    assign_profiles_to_company(profiles=profiles, company=company)

    assert profiles[0].companies.first() == company
    assert profiles[1].companies.first() == company


@pytest.mark.django_db
def test_create_team_members_profiles():
    """Register new profiles from TeamMembersRepresentation."""
    team_members_repr = TeamMembersRepresentation(team_members=[
        {'name': 'Marcin', 'email': 'marcin@email.com'},
        {'name': 'Karolina', 'email': 'karolina@email.com'},
    ])

    profiles = create_team_members_profiles(team_members=team_members_repr)

    assert Profile.objects.count() == 2
    assert set(Profile.objects.all()) == set(profiles)


@pytest.mark.django_db
def test_create_team_members_for_existing_profile():
    """If the profile in TeamMembersRepresentation exists, just return it."""
    profile1 = ProfileFactory.create()
    profile1_name, profile1_email = profile1.name, profile1.user.email

    team_members_repr = TeamMembersRepresentation(team_members=[
        {'name': 'Marcin', 'email': 'marcin@email.com'},
        {'name': profile1_name, 'email': profile1_email},
    ])

    profiles = create_team_members_profiles(team_members=team_members_repr)

    assert Profile.objects.count() == 2
    assert set(Profile.objects.all()) == set(profiles)
