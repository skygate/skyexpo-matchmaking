# -*- coding: utf-8 -*-

from django.conf import settings
from django.contrib.auth import get_user_model
from django.utils.translation import ugettext as ugt
from django_countries.serializer_fields import CountryField
from glom import glom
from phonenumber_field.serializerfields import PhoneNumberField
from rest_framework import serializers

from server.apps.company.constants import (
  BusinessType,
  CompanyStage,
  Industry,
  InvestmentStage,
  ProductType,
  Sector,
)
from server.apps.company.models import Company
from server.apps.profile.models import Profile

User = get_user_model()


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
    logotype = serializers.ImageField()

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


class TeamMembersSerializer(serializers.Serializer):
    """
    Validates the input data for 'team members' in the second
    step of the form, which registers company.
    Intended to use in 'CompanyValidateFormStep2Serializer'.
    """

    default_error_messages = {
        'member_email_taken': ugt('E-mail {value} is already taken.'),
    }

    name = serializers.CharField(max_length=255)
    email = serializers.EmailField()

    def validate(self, attrs):
        active_profiles = Profile.objects.active_profiles()
        taken_email = active_profiles.filter(user__email=attrs['email'])

        if taken_email.exists():
            raise serializers.ValidationError(
                self.fail('member_email_taken', value=attrs['email']),
            )

        return attrs


class CompanyValidateFormStep2Serializer(serializers.Serializer):
    """
    Validates the input data in the second step of the form,
    which registers company.
    """

    default_error_messages = {
        'email_taken': ugt('E-mail {value} is already taken.'),
        'one_of_emails_taken': ugt("One of team member's email is taken."),
        'email_duplicated': ugt("You can't enter the {email} more than once."),
    }

    founder_name = serializers.CharField(max_length=255)
    founder_email = serializers.EmailField(
        help_text='E-mail address of the person who completes the form.',
    )
    team_members = TeamMembersSerializer(many=True, required=True)

    def validate_founder_email(self, founder_email):
        active_profiles = Profile.objects.active_profiles()
        taken_email = active_profiles.filter(user__email=founder_email)

        if taken_email.exists():
            raise serializers.ValidationError(
                self.fail('email_taken', value=founder_email),
            )

        return founder_email

    def validate(self, attrs):
        members_emails = glom(attrs, ('team_members', ['email']))
        founder_email = attrs['founder_email']
        if founder_email in members_emails:
            self.fail('email_duplicated', email=founder_email)

        return attrs


class CompanyValidateFormStep3Serializer(serializers.Serializer):
    """
    Validates the input data in the third step of the form,
    which registers company.
    """

    default_error_messages = {
        'investment_size': ugt(
            'Maximum investment size should be lower or' +
            ' equal to minimum investment size.',
        ),
    }

    industries = serializers.MultipleChoiceField(choices=Industry.CHOICES)
    sectors = serializers.MultipleChoiceField(choices=Sector.CHOICES)
    product_types = serializers.MultipleChoiceField(
        choices=ProductType.CHOICES,
    )
    company_stage = serializers.ChoiceField(choices=CompanyStage.CHOICES)
    investment_stage = serializers.MultipleChoiceField(
        choices=InvestmentStage.CHOICES,
    )
    min_investment_size = serializers.IntegerField(
        min_value=0, help_text='In EUR currency.',
    )
    max_investment_size = serializers.IntegerField(
        help_text='In EUR currency.',
    )
    is_product_on_market = serializers.BooleanField()
    business_type = serializers.ChoiceField(choices=BusinessType.CHOICES)

    def validate(self, attrs):
        if attrs['max_investment_size'] < attrs['min_investment_size']:
            self.fail('investment_size')

        return attrs
