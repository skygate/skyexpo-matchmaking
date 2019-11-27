# -*- coding: utf-8 -*-

"""
This module is used to provide configuration, fixtures, and plugins for pytest.

It may be also used for extending doctest's context:
1. https://docs.python.org/3/library/doctest.html
2. https://docs.pytest.org/en/latest/doctest.html
"""
import factory
import pytest

from tests.factories import CompanyFactory


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
    }
