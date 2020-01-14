# -*- coding: utf-8 -*-

"""
This module is used to provide configuration, fixtures, and plugins for pytest.

It may be also used for extending doctest's context:
1. https://docs.python.org/3/library/doctest.html
2. https://docs.pytest.org/en/latest/doctest.html
"""
import factory
import pytest
from django.contrib.auth import get_user_model
from django.test import Client
from rest_framework.test import APIClient

from tests.factories import CompanyFactory, ProfileFactory, StartupFactory

User = get_user_model()


@pytest.fixture(autouse=True)
def _media_root(settings, tmpdir_factory):
    """Forces django to save media files into temp folder."""
    settings.MEDIA_ROOT = tmpdir_factory.mktemp('media', numbered=True)


@pytest.fixture(autouse=True)
def _password_hashers(settings):
    """Forces django to use fast password hashers for tests."""
    settings.PASSWORD_HASHERS = [
        'django.contrib.auth.hashers.MD5PasswordHasher',
    ]


@pytest.fixture(autouse=True)
def _auth_backends(settings):
    """Deactivates security backend from Axes app."""
    settings.AUTHENTICATION_BACKENDS = (
        'django.contrib.auth.backends.ModelBackend',
    )


@pytest.fixture()
def company_data():
    """Returns company fake data."""
    return factory.build(dict, FACTORY_CLASS=CompanyFactory)


@pytest.fixture()
def company(db):
    """Saves fake company to db and returns it."""
    return CompanyFactory.create()


@pytest.fixture()
def startup(db):
    """Saves fake startup to db and returns it."""
    return StartupFactory.create()


@pytest.fixture()
def company_step1_data(company_data):
    """Returns company fake data for step1 in registering form."""
    return {
        'name': company_data['name'],
        'email': company_data['email'],
        'phone_number': company_data['phone_number'],
        'website': company_data['website'],
        'country': company_data['country'],
        'founding_date': company_data['founding_date'],
        'description': company_data['description'],
        'logotype': company_data['logotype'],
    }


@pytest.fixture()
def company_step2_data(user, company_data):
    """Returns company fake data for step2 in registering form."""
    profile1 = ProfileFactory.build()
    profile2 = ProfileFactory.build()

    return {
        'team_members': [
            {'name': profile1.name, 'email': profile1.user.email},
            {'name': profile2.name, 'email': profile2.user.email},
        ],
    }


@pytest.fixture()
def company_step3_data(company_data):
    """Returns company fake data for step3 in registering form."""
    return {
        'sectors': company_data['sectors'],
        'industries': company_data['industries'],
        'product_types': company_data['product_types'],
        'stage': company_data['stage'],
        'investment_stage': company_data['investment_stage'],
        'business_type': company_data['business_type'],
        'is_product_on_market': company_data['is_product_on_market'],
        'min_investment_size': company_data['investment_size'].lower,
        'max_investment_size': company_data['investment_size'].upper,
    }


@pytest.fixture()
def company_create_data(
    company_step1_data, company_step2_data, company_step3_data,
):
    """Returns example data needed for company creation."""
    data = {
        **company_step1_data,
        **company_step2_data,
        **company_step3_data,
    }
    # TODO: Set up sending images.
    data.pop('logotype')

    return data


@pytest.fixture()
def admin_user(db):
    """Returns a Django admin user."""
    return User.objects.create_superuser('admin@example.com', 'password')


@pytest.fixture()
def admin_client(admin_user):
    """Returns a Django test client logged in as an admin user."""
    client = Client()
    client.login(username=admin_user.email, password='password')

    return client


@pytest.fixture()
def user(db):
    """Returns an example user."""
    return User.objects.create_user('user@example.com', 'password')


@pytest.fixture()
def inactive_user(db):
    """Returns an example inactive user."""
    user = User.objects.create_user('user@example.com', 'password')
    user.is_active = False
    user.save()
    return user


@pytest.fixture()
def api_client(user):
    """Returns DjangoRestFramework ApiClient"""
    client = APIClient()
    client.force_login(user)

    return client
