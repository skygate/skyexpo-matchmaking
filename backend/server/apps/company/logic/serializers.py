# -*- coding: utf-8 -*-

from django.conf import settings
from django_countries.serializer_fields import CountryField
from phonenumber_field.serializerfields import PhoneNumberField
from rest_framework import serializers

from server.apps.company.models import Company


class CompanyValidateFormStep1Serializer(serializers.Serializer):
    """
    Validates the input data in the first step of the form,
    which registers company.
    """

    name = serializers.CharField(max_length=120)
    website = serializers.URLField(
        allow_blank=True, help_text='Should be prefixed with http(s)://',
    )
    phone_number = PhoneNumberField(
        help_text=f'we use {settings.PHONENUMBER_DB_FORMAT} format ' +
        'for telephone numbers.',
    )
    email = serializers.EmailField()
    country = CountryField(
        help_text='We use ISO 3166-1 standard for country codes.',
    )
    founding_date = serializers.DateField()
    description = serializers.CharField(max_length=255, allow_blank=True)

    def validate_name(self, name):
        if Company.objects.filter(name=name).exists():
            raise serializers.ValidationError(
                'Company with this name already exists.',
            )
        return name

    def validate_email(self, email):
        if Company.objects.filter(email=email).exists():
            raise serializers.ValidationError(
                'Company with this e-mail already exists.',
            )
        return email
