# -*- coding: utf-8 -*-

from django.urls import path

from server.apps.company.views import (
  CompanyValidateFormStep1View,
  CompanyValidateFormStep2View,
  CompanyValidateFormStep3View,
)

app_name = 'company'

urlpatterns = [
    path(
        'form/step-1/',
        CompanyValidateFormStep1View.as_view(),
        name='validate-form-step-1',
    ),
    path(
        'form/step-2/',
        CompanyValidateFormStep2View.as_view(),
        name='validate-form-step-2',
    ),
    path(
        'form/step-3/',
        CompanyValidateFormStep3View.as_view(),
        name='validate-form-step-3',
    ),
]
