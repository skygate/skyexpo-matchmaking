# -*- coding: utf-8 -*-

from django.conf import settings
from django.contrib.auth import get_user_model
from django.utils.translation import ugettext as ugt
from django_countries.serializer_fields import CountryField
from phonenumber_field.serializerfields import PhoneNumberField
from rest_framework import serializers

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


class CompanyValidateFormStep2Serializer(serializers.Serializer):
    """
    Validates the input data in the second step of the form,
    which registers company.
    """

    default_error_messages = {
        'email_taken': ugt('E-mail {value} is already taken.'),
        'one_of_emails_taken': ugt("One of team member's email is taken."),
    }

    logotype = serializers.ImageField()
    founder_email = serializers.EmailField(
        help_text='E-mail address of the person who completes the form.',
    )
    team_members = serializers.ListField(
        child=serializers.EmailField(), allow_empty=False,
    )

    def validate_founder_email(self, founder_email):
        active_profiles = Profile.objects.active_profiles()
        taken_email = active_profiles.filter(user__email=founder_email)

        if taken_email.exists():
            raise serializers.ValidationError(
                self.fail('email_taken', value=founder_email),
            )

        return founder_email

    def validate_team_members(self, team_members):
        active_profiles = Profile.objects.active_profiles()
        taken_emails = active_profiles.filter(user__email__in=team_members)

        if taken_emails.exists():
            raise serializers.ValidationError(
                self.fail('one_of_emails_taken'),
            )

        return team_members
