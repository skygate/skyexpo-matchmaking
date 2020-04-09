# -*- coding: utf-8 -*-

from typing import Final, List, Tuple

from django.utils.translation import gettext_lazy as gtl

ChoicesType = List[Tuple[str, str]]

MIN_INVESTMENT_VALUE: Final[int] = 0
MAX_INTEGER_FIELD_VALUE: Final[int] = 2147483647


class Sector:
    """Company's sector choices."""

    AI_AND_ROBOTICS = 'AI_AND_ROBOTICS'
    IOT_AND_SENSORS = 'IOT_AND_SENSORS'
    AGRICULTURE = 'AGRICULTURE'

    CHOICES: Final[ChoicesType] = [
        (AI_AND_ROBOTICS, gtl('AI and robotics')),
        (IOT_AND_SENSORS, gtl('IoT and sensors')),
        (AGRICULTURE, gtl('Agriculture')),
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

    CHOICES: Final[ChoicesType] = [
        (BUSINESS_ANALYTICS, gtl('Business & Analytics')),
        (FINANCIAL_SERVICES, gtl('Financial Services & Security')),
        (ENTERTAINMENT, gtl('Entertainment and Mobile')),
        (HEALTH_CARE, gtl('Health-care and Wellbeing')),
        (E_COMMERCE, gtl('E-commerce, Adtech, Martech')),
        (MATERIALS, gtl('Manufacturing and materials')),
        (HARDWARE, gtl('Hardware & Iot')),
        (MOBILITY, gtl('Mobility & Transportation')),
        (ENERGY, gtl('Energy and Cleantech')),
    ]


class CompanyStage:
    """Company's stage choices."""

    CONCEPT_STAGE = 'CONCEPT_STAGE'
    GROWTH_STAGE = 'GROWTH_STAGE'
    EARLY_STAGE = 'EARLY_STAGE'
    SEED_STAGE = 'SEED_STAGE'

    CHOICES: Final[ChoicesType] = [
        (CONCEPT_STAGE, gtl('Concept stage')),
        (GROWTH_STAGE, gtl('Growth stage (generating revenue)')),
        (EARLY_STAGE, gtl('Early stage (market launch)')),
        (SEED_STAGE, gtl('Seed stage (product development)')),
    ]


class ProductType:
    """Product-type choices."""

    SOFTWARE = 'SOFTWARE'
    HARDWARE = 'HARDWARE'
    OTHER = 'OTHER'

    CHOICES: Final[ChoicesType] = [
        (SOFTWARE, gtl('Software')),
        (HARDWARE, gtl('Hardware')),
        (OTHER, gtl('Other')),
    ]


class InvestmentStage:
    """Investment stage choices."""

    BUSINESS_ANGELS = 'BUSINESS_ANGELS'
    INCUBATOR = 'INCUBATOR'
    VENTURE_CAPITAL = 'VENTURE_CAPITAL'
    ACCELERATOR = 'ACCELERATOR'

    CHOICES: Final[ChoicesType] = [
        (BUSINESS_ANGELS, gtl('Business Angels')),
        (INCUBATOR, gtl('Incubator')),
        (VENTURE_CAPITAL, gtl('Venture Capital')),
        (ACCELERATOR, gtl('Accelerator')),
    ]


class BusinessType:
    """Business type choices."""

    B2B = 'B2B'
    B2C = 'B2C'

    CHOICES: Final[ChoicesType] = [
        (B2B, gtl('Business to Business')),
        (B2C, gtl('Business to Customer')),
    ]
