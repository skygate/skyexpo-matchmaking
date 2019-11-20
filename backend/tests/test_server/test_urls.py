# -*- coding: utf-8 -*-

import pytest


def test_admin_unauthorized(client):
    """This test ensures that admin panel requires auth."""
    response = client.get('/admin/')

    assert response.status_code == 302


@pytest.mark.django_db
def test_health_check(client):
    """This test ensures that health check is accessible."""
    response = client.get('/health/')

    assert response.status_code == 200


def test_admin_authorized(admin_client):
    """This test ensures that admin panel is accessible."""
    response = admin_client.get('/admin/')

    assert response.status_code == 200
