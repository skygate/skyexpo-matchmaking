# -*- coding: utf-8 -*-

import json

import pytest
from rest_framework import status
from rest_framework.reverse import reverse


@pytest.mark.django_db
def test_register_company_step1(api_client, company_step1_data):
    """
    Ensures that 'company:validate-form-step-1' endpoint validates,
    the input data in the first step of the company registration form.
    """
    response = api_client.post(
        reverse('company:validate-form-step-1'), data=company_step1_data,
    )

    assert response.status_code == status.HTTP_204_NO_CONTENT


@pytest.mark.django_db
def test_register_company_step2(api_client, company_step2_data):
    """
    Ensures that 'company:validate-form-step-2' endpoint validates,
    the input data in the second step of the company registration form.
    """
    response = api_client.post(
        reverse('company:validate-form-step-2'),
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
        reverse('company:validate-form-step-3'), data=company_step3_data,
    )

    assert response.status_code == status.HTTP_204_NO_CONTENT
