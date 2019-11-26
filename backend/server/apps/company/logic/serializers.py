# -*- coding: utf-8 -*-

from django.conf import settings
from django.utils.translation import ugettext as ugt
from django_countries.serializer_fields import CountryField
from phonenumber_field.serializerfields import PhoneNumberField
from rest_framework import serializers

from server.apps.company.models import Company


class CompanyValidateFormStep1Serializer(serializers.Serializer):
    """
    Validates the input data in the first step of the form,
    which registers company.
    """

    default_error_messages = {
        'field_value_exists': ugt('Company with this {field} already exists.'),
    }

    name = serializers.CharField(max_length=120)
    website = serializers.URLField(
        allow_blank=True, help_text='Should be prefixed with http(s)://',
    )
    phone_number = PhoneNumberField(
        help_text=f'We use {settings.PHONENUMBER_DB_FORMAT} format ' +
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
                self.fail('field_value_exists', field='name'),
            )
        return name

    def validate_email(self, email):
        if Company.objects.filter(email=email).exists():
            raise serializers.ValidationError(
                self.fail('field_value_exists', field='e-mail'),
            )
        return email
