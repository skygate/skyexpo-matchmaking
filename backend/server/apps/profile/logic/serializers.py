# -*- coding: utf-8 -*-

from django.conf import settings
from django.contrib.auth import get_user_model
from django_countries.serializer_fields import CountryField
from phonenumber_field.serializerfields import PhoneNumberField
from rest_framework import serializers

from server.apps.profile.constants import (
  BusinessType,
  CompanyStage,
  Industry,
  InvestmentStage,
  ProductType,
  Sector,
)
from server.apps.profile.models import MAX_INTEGER_FIELD_VALUE

User = get_user_model()


class CompanyValidateFormStep1Serializer(serializers.Serializer):
    """
    Validates the input data schema in the first step of the form,
    which registers company.
    """

    name = serializers.CharField(max_length=255)
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
    description = serializers.CharField(allow_blank=True)
    logotype = serializers.ImageField(required=False)


class TeamMembersSerializer(serializers.Serializer):
    """
    Validates the input data schema for 'team members' in the second
    step of the form, which registers company.
    Intended to use in 'CompanyValidateFormStep2Serializer'.
    """

    name = serializers.CharField(max_length=255)
    email = serializers.EmailField()


class CompanyValidateFormStep2Serializer(serializers.Serializer):
    """
    Validates the input data schema in the second step of the form,
    which registers company.
    """

    team_members = TeamMembersSerializer(many=True, required=True)


class CompanyValidateFormStep3Serializer(serializers.Serializer):
    """
    Validates the input data schema in the third step of the form,
    which registers company.
    """

    industries = serializers.MultipleChoiceField(choices=Industry.CHOICES)
    sectors = serializers.MultipleChoiceField(choices=Sector.CHOICES)
    product_types = serializers.MultipleChoiceField(
        choices=ProductType.CHOICES,
    )
    stage = serializers.ChoiceField(choices=CompanyStage.CHOICES)
    investment_stage = serializers.MultipleChoiceField(
        choices=InvestmentStage.CHOICES,
    )
    min_investment_size = serializers.IntegerField(
        min_value=0, help_text='In EUR currency.',
    )
    max_investment_size = serializers.IntegerField(
        max_value=MAX_INTEGER_FIELD_VALUE, help_text='In EUR currency.',
    )
    is_product_on_market = serializers.BooleanField()
    business_type = serializers.ChoiceField(choices=BusinessType.CHOICES)
