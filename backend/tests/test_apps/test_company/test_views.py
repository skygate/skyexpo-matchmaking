# -*- coding: utf-8 -*-

import pytest
from rest_framework import status
from rest_framework.reverse import reverse


@pytest.mark.django_db
def test_register_company_step1(client, company_step1_data):
    """
    Ensures that 'company:validate-form-step-1' endpoint validates,
    the input data in the first step of the company registration form.
    """
    response = client.post(
        reverse('company:validate-form-step-1'), data=company_step1_data,
    )

    assert response.status_code == status.HTTP_204_NO_CONTENT


@pytest.mark.django_db
def test_register_company_step2(client, company_step2_data):
    """
    Ensures that 'company:validate-form-step-2' endpoint validates,
    the input data in the second step of the company registration form.
    """
    response = client.post(
        reverse('company:validate-form-step-2'), data=company_step2_data,
    )

    assert response.status_code == status.HTTP_204_NO_CONTENT
