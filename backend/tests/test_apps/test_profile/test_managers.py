# -*- coding: utf-8 -*-

import pytest


@pytest.mark.django_db
def test_create_user(django_user_model):
    """This test ensures that create_user creates user properly."""
    user = django_user_model.objects.create_user(
        email='user@email.com', password='password',
    )

    assert user
    assert user.is_staff is False
    assert user.is_superuser is False


@pytest.mark.django_db
def test_create_superuser(django_user_model):
    """This test ensures that create_superuser creates admin properly."""
    user = django_user_model.objects.create_superuser(
        email='user@email.com', password='password',
    )

    assert user
    assert user.is_staff is True
    assert user.is_superuser is True


def test_create_superuser_without_email(django_user_model):
    """This test ensures that you cannot create superuser without email."""
    with pytest.raises(ValueError, match='The given email must be set'):
        django_user_model.objects.create_superuser(
            email='', password='password',
        )
