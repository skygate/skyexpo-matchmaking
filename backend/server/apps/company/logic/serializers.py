# -*- coding: utf-8 -*-
from django_countries.serializer_fields import CountryField
from phonenumber_field.serializerfields import PhoneNumberField
from rest_framework import serializers
from django.conf import settings


class CompanyValidateFormStep1Serializer(serializers.Serializer):
    """Validates the input data in the first step of the form,
     which registers company."""

    name = serializers.CharField(max_length=120)
    website = serializers.URLField(allow_blank=True, help_text='Should be prefixed with http(s)://')
    phone = PhoneNumberField(
        help_text=f'we use {settings.PHONENUMBER_DB_FORMAT} format '
        f'for telephone numbers.'
    )
    email = serializers.EmailField()
    country = CountryField(help_text='We use ISO 3166-1 standard for country codes.')
    founding_date = serializers.DateField()
    description = serializers.CharField(max_length=255, allow_blank=True)
