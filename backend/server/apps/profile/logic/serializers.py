# -*- coding: utf-8 -*-

from django.conf import settings
from django.contrib.auth import get_user_model
from django_countries.serializer_fields import CountryField
from phonenumber_field.serializerfields import PhoneNumberField
from rest_framework import serializers

from server.apps.profile.constants import (
  MAX_INTEGER_FIELD_VALUE,
  BusinessType,
  CompanyStage,
)
from server.apps.profile.models import AngelInvestor, Company, Profile, Startup

User = get_user_model()


class MainInfoCommonSerializer(serializers.Serializer):
    """
    Common fields used in 'Main info' step in register forms
    for Startup, Company and AngelInvestor.
    """

    website = serializers.URLField(
        allow_blank=True, help_text='Should be prefixed with http(s)://',
    )
    phone_number = PhoneNumberField(
        help_text=f'We use {settings.PHONENUMBER_DB_FORMAT} format ' +
        'for telephone numbers.',
    )
    country = CountryField(
        help_text='We use ISO 3166-1 standard for country codes.',
    )
    founding_date = serializers.DateField()
    description = serializers.CharField(allow_blank=True)


class MatchmakingCommonSerializer(serializers.Serializer):
    """
    Common fields used in 'Matching parameters' step in register forms
    for Startup, Company and AngelInvestor.
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


class CompanyValidateFormStep1Serializer(MainInfoCommonSerializer):
    """
    Validates the input data schema in the first step of the form,
    which registers company.
    """

    name = serializers.CharField(max_length=255)
    email = serializers.EmailField()


class UploadLogotypeStep1Serializer(serializers.Serializer):
    """Validates the input data for a logotype."""

    logotype = serializers.ImageField(
        required=False, help_text='Available formats: .jpg, .jpeg, .png, .gif.',
    )


class TeamMembersSerializer(serializers.Serializer):
    """
    Validates the input data schema for 'team members' in the second
    step of the form, which registers company.
    Intended to use in 'CompanyValidateFormStep2Serializer' and
    'StartupValidateFormStep2Serializer'.
    """

    name = serializers.CharField(max_length=255)
    email = serializers.EmailField()


class CompanyValidateFormStep2Serializer(serializers.Serializer):
    """
    Validates the input data schema in the second step of the form,
    which registers company.
    """

    team_members = TeamMembersSerializer(many=True, required=True)


class CompanyValidateFormStep3Serializer(MatchmakingCommonSerializer):
    """
    Validates the input data schema in the third step of the form,
    which registers company.
    """

    pass  # noqa: WPS604, WPS420


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

    logotype = serializers.CharField()


class ProfileNestedOutputSerializer(serializers.ModelSerializer):
    """Serializes nested read-only output for the Profile model."""

    email = serializers.EmailField(source='user.email', read_only=True)

    class Meta:
        model = Profile
        fields = ['id', 'name', 'email']
        read_only_fields = fields


class CompanyCreateOutputSerializer(serializers.ModelSerializer):
    """Serializes read-only output for the Company model."""

    profiles = ProfileNestedOutputSerializer(
        source='get_profiles', many=True, read_only=True,
    )

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


class StartupValidateFormStep1Serializer(MainInfoCommonSerializer):
    """
    Validates the input data schema in the first step of the form,
    which registers startup.
    """

    name = serializers.CharField(max_length=255)
    email = serializers.EmailField()


class StartupValidateFormStep2Serializer(serializers.Serializer):
    """
    Validates the input data schema in the second step of the form,
    which registers startup.
    """

    team_members = TeamMembersSerializer(many=True, required=True)


class StartupValidateFormStep3Serializer(MatchmakingCommonSerializer):
    """
    Validates the input data schema in the third step of the form,
    which registers startup.
    """

    pass  # noqa: WPS604, WPS420


class StartupCreateInputSerializer(
    StartupValidateFormStep1Serializer,
    StartupValidateFormStep2Serializer,
    StartupValidateFormStep3Serializer,
):
    """
    In the last step of the form when the user triggers the 'Finish' button,
    the client combines together every field from the previous steps and sends
    it to the API. This serializer validates this input schema.
    """

    logotype = serializers.CharField()


class StartupCreateOutputSerializer(serializers.ModelSerializer):
    """Serializes read-only output for the Startup model."""

    profiles = ProfileNestedOutputSerializer(
        source='get_profiles', many=True, read_only=True,
    )

    class Meta:
        model = Startup
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


class AngelInvestorValidateFormStep1Serializer(MainInfoCommonSerializer):
    """
    Validates the input data schema in the first step of the form,
    which registers AngelInvestor.
    """

    name = serializers.CharField(max_length=255)
    email = serializers.EmailField()


class AngelInvestorValidateFormStep2Serializer(MatchmakingCommonSerializer):
    """
    Validates the input data schema in the second step of the form,
    which registers AngelInvestor.
    """

    pass  # noqa: WPS604, WPS420


class AngelInvestorCreateInputSerializer(
    AngelInvestorValidateFormStep1Serializer,
    AngelInvestorValidateFormStep2Serializer,
):
    """
    In the last step of the form when the user triggers the 'Finish' button,
    the client combines together every field from the previous steps and sends
    it to the API. This serializer validates this input schema.
    """

    logotype = serializers.CharField()


class AngelInvestorCreateOutputSerializer(serializers.ModelSerializer):
    """Serializes read-only output for the AngelInvestor model."""

    profile = ProfileNestedOutputSerializer(read_only=True)

    class Meta:
        model = AngelInvestor
        fields = [
            'id',
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
            'profile',
        ]
        read_only_fields = fields


class ProfileCreateInputSerializer(serializers.Serializer):
    """Serializes input for the ProfileCreate View."""

    name = serializers.CharField(max_length=255)
    email = serializers.EmailField()
    password = serializers.CharField(
        write_only=True,
        style={'input_type': 'password'},
    )


class ProfileCreateOutputSerializer(serializers.ModelSerializer):
    """Serializes output for the ProfileCreate View."""

    email = serializers.EmailField(source='user.email', read_only=True)
    is_active = serializers.BooleanField(
        source='user.is_active', read_only=True,
    )

    class Meta:
        model = Profile
        fields = ['id', 'name', 'email', 'is_active']
        read_only_fields = fields
