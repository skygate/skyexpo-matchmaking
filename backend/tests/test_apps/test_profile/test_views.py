# -*- coding: utf-8 -*-

import json
import tempfile
from unittest.mock import patch

import pytest
from PIL import Image
from rest_framework import status
from rest_framework.reverse import reverse

from tests.factories import ProfileFactory


@pytest.mark.django_db
def test_register_company_step1(api_client, company_step1_data):
    """
    Ensures that 'company:validate-form-step-1' endpoint validates,
    the input data in the first step of the company registration form.
    """
    response = api_client.post(
        reverse('validate-form-company-step-1'), data=company_step1_data,
    )

    assert response.status_code == status.HTTP_204_NO_CONTENT


@pytest.mark.django_db
def test_register_company_step2(api_client, company_step2_data):
    """
    Ensures that 'company:validate-form-step-2' endpoint validates,
    the input data in the second step of the company registration form.
    """
    response = api_client.post(
        reverse('validate-form-company-step-2'),
        data=json.dumps(company_step2_data),
        content_type='application/json',
    )
    assert response.status_code == status.HTTP_204_NO_CONTENT


@pytest.mark.django_db
def test_register_company_step3(api_client, company_step3_data):
    """
    Ensures that 'company:validate-form-step-3' endpoint validates,
    the input data in the third step of the company registration form.
    """
    response = api_client.post(
        reverse('validate-form-company-step-3'), data=company_step3_data,
    )

    assert response.status_code == status.HTTP_204_NO_CONTENT


@pytest.mark.django_db
@patch('server.apps.profile.views.create_company')
@patch('server.apps.profile.views.create_team_members_profiles')
@patch('server.apps.profile.views.assign_profiles_to_company')
def test_company_create_view(
    assign_profiles_to_company_mock,
    create_team_members_profiles_mock,
    create_company_mock,
    api_client,
    company_create_data,
):
    """
    Ensures that 'profile:company-create' endpoint calls desired functions
    and creates company correctly.
    """
    response = api_client.post(
        reverse('profile:company-create'),
        data=json.dumps(company_create_data),
        content_type='application/json',
    )

    assert response.status_code == status.HTTP_201_CREATED

    create_company_mock.assert_called()
    create_team_members_profiles_mock.assert_called()
    assign_profiles_to_company_mock.assert_called()


@pytest.mark.django_db
def test_register_startup_step1(api_client, company_step1_data):
    """
    Ensures that ':validate-form-startup-step-1' endpoint validates,
    the input data in the first step of the startup registration form.
    """
    response = api_client.post(
        reverse('validate-form-startup-step-1'), data=company_step1_data,
    )

    assert response.status_code == status.HTTP_204_NO_CONTENT


@pytest.mark.django_db
def test_register_startup_step2(api_client, company_step2_data):
    """
    Ensures that 'validate-form-startup-step-2' endpoint validates,
    the input data in the second step of the startup registration form.
    """
    response = api_client.post(
        reverse('validate-form-startup-step-2'),
        data=json.dumps(company_step2_data),
        content_type='application/json',
    )
    assert response.status_code == status.HTTP_204_NO_CONTENT


@pytest.mark.django_db
def test_register_startup_step3(api_client, company_step3_data):
    """
    Ensures that 'validate-form-startup-step-3' endpoint validates,
    the input data in the third step of the startup registration form.
    """
    response = api_client.post(
        reverse('validate-form-startup-step-3'), data=company_step3_data,
    )

    assert response.status_code == status.HTTP_204_NO_CONTENT


@pytest.mark.django_db
@patch('server.apps.profile.views.create_startup')
@patch('server.apps.profile.views.create_team_members_profiles')
@patch('server.apps.profile.views.assign_profiles_to_startup')
def test_startup_create_view(
    assign_profiles_to_startup_mock,
    create_team_members_profiles_mock,
    create_company_mock,
    api_client,
    company_create_data,
):
    """
    Ensures that 'profile:startup-create' endpoint calls desired functions
    and creates startup correctly.
    """
    response = api_client.post(
        reverse('profile:startup-create'),
        data=json.dumps(company_create_data),
        content_type='application/json',
    )

    assert response.status_code == status.HTTP_201_CREATED

    create_company_mock.assert_called()
    create_team_members_profiles_mock.assert_called()
    assign_profiles_to_startup_mock.assert_called()


@pytest.mark.django_db
def test_register_angel_investor_step1(api_client, company_step1_data):
    """
    Ensures that ':validate-form-investor-step-1' endpoint validates,
    the input data in the first step of the startup registration form.
    """
    response = api_client.post(
        reverse('validate-form-investor-step-1'), data=company_step1_data,
    )

    assert response.status_code == status.HTTP_204_NO_CONTENT


@pytest.mark.django_db
def test_register_angel_investor_step2(api_client, company_step3_data):
    """
    Ensures that ':validate-form-investor-step-2' endpoint validates,
    the input data in the first step of the startup registration form.
    """
    response = api_client.post(
        reverse('validate-form-investor-step-2'), data=company_step3_data,
    )

    assert response.status_code == status.HTTP_204_NO_CONTENT


@pytest.mark.django_db
@patch('server.apps.profile.views.create_angel_investor')
def test_angel_investor_create_view(
    create_angel_investor_mock,
    api_client,
    company_create_data,
):
    """
    Ensures that 'profile:investor-create' endpoint calls desired functions
    and creates investor correctly.
    """
    company_create_data.pop('team_members')
    response = api_client.post(
        reverse('profile:investor-create'),
        data=json.dumps(company_create_data),
        content_type='application/json',
    )

    assert response.status_code == status.HTTP_201_CREATED

    create_angel_investor_mock.assert_called()


@pytest.mark.django_db
def test_profile_create_view(api_client):
    """Ensures that 'profile:profile' endpoint creates new user's profile."""
    profile = ProfileFactory.build()

    response = api_client.post(
        reverse('profile:profile'), data={
            'email': profile.user.email,
            'name': profile.name,
            'password': 'password',
        },
    )

    assert response.status_code == status.HTTP_201_CREATED


@patch('server.apps.profile.views.upload_file')
def test_upload_logotype_step1_view(upload_file, api_client):
    """Ensures that 'upload-logotype-step-1' endpoint calls upload_file"""
    # GIVEN Image
    image = Image.new('RGB', (100, 100))
    tmp_image = tempfile.NamedTemporaryFile(suffix='.jpg')
    image.save(tmp_image)
    tmp_image.seek(0)

    # WHEN send image to upload-logotype-step-1
    response = api_client.post(
        reverse('upload-logotype-step-1'),
        {'logotype': tmp_image},
        format='multipart',
    )

    # THEN save file to storage
    upload_file.assert_called_once()
    assert response.status_code == status.HTTP_201_CREATED
