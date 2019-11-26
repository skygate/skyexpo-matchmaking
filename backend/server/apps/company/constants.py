# -*- coding: utf-8 -*-

from django.utils.translation import ugettext_lazy as ugtl
from typing_extensions import Final


class Sector:
    """Company's sector choices."""

    AI_AND_ROBOTICS = 'AI_AND_ROBOTICS'
    IOT_AND_SENSORS = 'IOT_AND_SENSORS'
    AGRICULTURE = 'AGRICULTURE'

    CHOICES: Final = [
        (AI_AND_ROBOTICS, ugtl('AI and robotics')),
        (IOT_AND_SENSORS, ugtl('IoT and sensors')),
        (AGRICULTURE, ugtl('Agriculture')),
    ]


class Industry:
    """Company's industry choices."""

    BUSINESS_ANALYTICS = 'BUSINESS_ANALYTICS'
    FINANCIAL_SERVICES = 'FINANCIAL_SERVICES'
    ENTERTAINMENT = 'ENTERTAINMENT'
    HEALTH_CARE = 'HEALTH_CARE'
    E_COMMERCE = 'E_COMMERCE'
    MATERIALS = 'MATERIALS'
    HARDWARE = 'HARDWARE'
    MOBILITY = 'MOBILITY'
    ENERGY = 'ENERGY'

    CHOICES: Final = [
        (BUSINESS_ANALYTICS, ugtl('Business & Analytics')),
        (FINANCIAL_SERVICES, ugtl('Financial Services & Security')),
        (ENTERTAINMENT, ugtl('Entertainment and Mobile')),
        (HEALTH_CARE, ugtl('Health-care and Wellbeing')),
        (E_COMMERCE, ugtl('E-commerce, Adtech, Martech')),
        (MATERIALS, ugtl('Manufacturing and materials')),
        (HARDWARE, ugtl('Hardware & Iot')),
        (MOBILITY, ugtl('Mobility & Transportation')),
        (ENERGY, ugtl('Energy and Cleantech')),
    ]


class CompanyStage:
    """Company's stage choices."""

    CONCEPT_STAGE = 'CONCEPT_STAGE'
    GROWTH_STAGE = 'GROWTH_STAGE'
    EARLY_STAGE = 'EARLY_STAGE'
    SEED_STAGE = 'SEED_STAGE'

    CHOICES: Final = [
        (CONCEPT_STAGE, ugtl('Concept stage')),
        (GROWTH_STAGE, ugtl('Growth stage (generating revenue)')),
        (EARLY_STAGE, ugtl('Early stage (market launch)')),
        (SEED_STAGE, ugtl('Seed stage (product development)')),
    ]


class ProductType:
    """Product type choices."""

    SOFTWARE = 'SOFTWARE'
    HARDWARE = 'HARDWARE'
    OTHER = 'OTHER'

    CHOICES: Final = [
        (SOFTWARE, ugtl('Software')),
        (HARDWARE, ugtl('Hardware')),
        (OTHER, ugtl('Other')),
    ]
