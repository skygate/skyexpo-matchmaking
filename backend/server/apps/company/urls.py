# -*- coding: utf-8 -*-

from django.urls import path

from server.apps.company.views import CompanyValidateFormStep1View

app_name = 'company'

urlpatterns = [
    path('form/step-1/', CompanyValidateFormStep1View.as_view(), name='validate-form-step-1'),
]
