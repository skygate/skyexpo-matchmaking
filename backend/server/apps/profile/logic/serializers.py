# -*- coding: utf-8 -*-

from django.conf import settings
from django.contrib.auth import get_user_model
from django_countries.serializer_fields import CountryField
from phonenumber_field.serializerfields import PhoneNumberField
from rest_framework import serializers

from server.apps.profile.constants import BusinessType, CompanyStage
from server.apps.profile.models import MAX_INTEGER_FIELD_VALUE, Company

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
        'for telephone numbers.', required=False,
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

    industries = serializers.ListField()
    sectors = serializers.ListField()
    product_types = serializers.ListField()
    stage = serializers.ChoiceField(choices=CompanyStage.CHOICES)
    investment_stage = serializers.ListField()
    min_investment_size = serializers.IntegerField(
        min_value=0, help_text='In EUR currency.',
    )
    max_investment_size = serializers.IntegerField(
        max_value=MAX_INTEGER_FIELD_VALUE, help_text='In EUR currency.',
    )
    is_product_on_market = serializers.BooleanField()
    business_type = serializers.ChoiceField(choices=BusinessType.CHOICES)


class CompanyCreateInputSerializer(
    CompanyValidateFormStep1Serializer,
    CompanyValidateFormStep2Serializer,
    CompanyValidateFormStep3Serializer,
):
    """
    In the last step of the form when the user triggers the 'Finish' button,
    the client combines together every field from the previous steps and sends
    it to the API. This serializer validates this input schema.
    """

    pass  # noqa: WPS604, WPS420


class CompanyCreateOutputSerializer(serializers.ModelSerializer):
    """Serializes read-only output for the Company model."""

    class Meta:
        model = Company
        fields = [
            'id',
            'name',
            'email',
            'logotype',
            'website',
            'phone_number',
            'country',
            'founding_date',
            'description',
            'stage',
            'sectors',
            'industries',
            'product_types',
            'investment_stage',
            'is_product_on_market',
            'business_type',
            'investment_size',
            'profiles',
        ]
        read_only_fields = fields
        depth = 1  # TODO: Change to NestedSerializer
