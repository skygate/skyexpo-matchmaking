# -*- coding: utf-8 -*-

from unittest.mock import MagicMock, patch

import pytest
from django.core.exceptions import ValidationError
from django.core.files.base import ContentFile

from server.apps.profile.logic.representations import (
  AngelInvestorRepresentation,
  CompanyRepresentation,
  StartupRepresentation,
)
from server.apps.profile.logic.selectors import is_assigned
from server.apps.profile.logic.services import (
  activate_profile,
  assign_profile_to_company,
  assign_profile_to_startup,
  assign_profiles_to_company,
  assign_profiles_to_startup,
  check_for_duplicated_emails,
  create_angel_investor,
  create_company,
  create_inactive_profile,
  create_startup,
  create_team_members_profiles,
  register_user,
  upload_file,
  validate_team_members_form,
)
from server.apps.profile.models import AngelInvestor, Company, Profile, Startup
from tests.factories import ProfileFactory, UserFactory


def test_check_for_duplicated_emails():
    """Ensures that function checks for duplicates correctly."""
    emails = ['marcin@jos.pl', 'marcin@jos.pl']

    with pytest.raises(
        ValidationError, match='You cannot enter the same email twice.',
    ):
        check_for_duplicated_emails(emails=emails)


@pytest.mark.django_db
def test_validate_team_members_form(company):
    """Checks if profiles are already assigned."""
    profile1 = ProfileFactory.create()
    profile2 = ProfileFactory.create(user=UserFactory.create(is_active=False))
    assign_profile_to_company(profile=profile1, company=company)

    team_members = [
        {'name': profile2.name, 'email': profile2.user.email},
        {'name': profile1.name, 'email': profile1.user.email},
    ]

    with pytest.raises(ValidationError):
        validate_team_members_form(team_members=team_members)


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
    profile = ProfileFactory.build()
    inactive_profile = create_inactive_profile(
        email=profile.user.email, name=profile.name,
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
    team_members = [
        {'name': 'Marcin', 'email': 'marcin@email.com'},
        {'name': 'Karolina', 'email': 'karolina@email.com'},
    ]

    profiles = create_team_members_profiles(team_members=team_members)

    assert Profile.objects.count() == 2
    assert set(Profile.objects.all()) == set(profiles)


@pytest.mark.django_db
def test_create_team_members_for_existing_profile():
    """If the profile exists just go on."""
    # GIVEN active profile and inactive profile
    profile1 = ProfileFactory.create()
    profile2 = ProfileFactory.create(user=UserFactory.create(is_active=False))
    team_members = [
        {'name': profile1.name, 'email': profile1.user.email},
        {'name': profile2.name, 'email': profile2.user.email},
    ]
    # WHEN create_team_members_profiles
    profiles = create_team_members_profiles(team_members=team_members)

    # THEN inactive profiles are activated and returned back
    # THEN existing active profiles are just returned back
    assert Profile.objects.filter(user__is_active=True).count() == 2
    assert set(Profile.objects.all()) == set(profiles)


@pytest.mark.django_db
def test_create_startup(company_data):
    """Ensures function creates startup from StartupRepresentation correctly."""
    company_data.pop('investment_size')
    startup_repr = StartupRepresentation(
        **company_data, min_investment_size=1, max_investment_size=2,
    )

    startup = create_startup(startup=startup_repr)

    assert Startup.objects.count() == 1
    assert list(Startup.objects.all()) == [startup]


@pytest.mark.django_db
def test_assign_profile_to_startup(startup):
    """Assigns existing profile to existing startup."""
    profile = ProfileFactory.create()

    assigned_profile = assign_profile_to_startup(
        profile=profile, startup=startup,
    )

    assert assigned_profile.startups.first() == startup


@pytest.mark.django_db
def test_assign_profiles_to_startup(startup):
    """Assigns many profiles to one startup."""
    profiles = [ProfileFactory.create(), ProfileFactory.create()]

    assign_profiles_to_startup(profiles=profiles, startup=startup)

    assert profiles[0].startups.first() == startup
    assert profiles[1].startups.first() == startup


@pytest.mark.django_db
def test_create_angel_investor(company_data):
    """Ensures function creates investor from AngelInvestorRepresentation."""
    company_data.pop('investment_size')
    company_data.pop('logotype')
    investor_repr = AngelInvestorRepresentation(
        **company_data, min_investment_size=1, max_investment_size=2,
    )

    investor = create_angel_investor(angel_investor=investor_repr)

    assert AngelInvestor.objects.count() == 1
    assert list(AngelInvestor.objects.all()) == [investor]


@pytest.mark.django_db
def test_register_new_user():
    user = UserFactory.build(is_active=False)
    profile = register_user(
        email=user.email,
        name='Name',
        password='password',
    )

    assert Profile.objects.count() == 1
    assert Profile.objects.first() == profile
    assert not profile.user.is_active
    assert not is_assigned(profile=profile)


@pytest.mark.django_db
def test_register_user_with_assigned_email(startup, inactive_user):
    profile = ProfileFactory.create(user=inactive_user)

    assigned_profile = assign_profile_to_startup(
        profile=profile, startup=startup,
    )

    assert not assigned_profile.user.is_active

    profile = register_user(
        email=assigned_profile.user.email,
        name=assigned_profile.name,
        password='password',
    )

    assert profile.user.is_active
    assert is_assigned(profile=profile)


@pytest.mark.django_db
def test_register_user_with_taken_email():
    profile = ProfileFactory.create()

    with pytest.raises(
        ValidationError, match='User with this Email already exists.',
    ):
        register_user(
            email=profile.user.email,
            name=profile.name,
            password=profile.user.password,
        )


@patch('server.apps.profile.logic.services.default_storage')
def test_upload_file(default_storage):
    # GIVEN storage_system & filename & file content
    file = MagicMock()
    file.name = 'filename'
    file.read = MagicMock(return_value=b'content')
    content = ContentFile(file.read())

    # WHEN upload_file is called
    upload_file(
        name=file.name,
        content=content,
    )

    # THEN save file to storage system
    default_storage.save.assert_called_once_with(file.name, content)


@pytest.mark.django_db
def test_activate_profile():
    # GIVEN inactive profile
    profile = ProfileFactory.create(user=UserFactory.create(is_active=False))

    # WHEN activate_profile is triggered
    activate_profile(email=profile.user.email)

    # THEN profile has been activated
    profile.user.refresh_from_db()
    assert profile.user.is_active
