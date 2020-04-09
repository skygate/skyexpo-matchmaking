# -*- coding: utf-8 -*-

import datetime
from dataclasses import dataclass
from typing import List, Optional, TypedDict

from django.contrib.auth import get_user_model
from phonenumber_field.phonenumber import PhoneNumber

User = get_user_model()

TeamMember = TypedDict('TeamMember', {'name': str, 'email': str})


@dataclass
class CompanyRepresentation:
    """Company data representation."""

    name: str
    email: str
    website: str
    country: str
    founding_date: datetime.date
    description: str
    industries: List[str]
    sectors: List[str]
    product_types: List[str]
    stage: str
    investment_stage: List[str]
    min_investment_size: int
    max_investment_size: int
    is_product_on_market: bool
    business_type: str
    logotype: Optional[str] = None
    phone_number: Optional[PhoneNumber] = None


@dataclass
class StartupRepresentation:
    """Startup data representation."""

    name: str
    email: str
    website: str
    country: str
    founding_date: datetime.date
    description: str
    industries: List[str]
    sectors: List[str]
    product_types: List[str]
    stage: str
    investment_stage: List[str]
    min_investment_size: int
    max_investment_size: int
    is_product_on_market: bool
    business_type: str
    logotype: Optional[str] = None
    phone_number: Optional[PhoneNumber] = None


@dataclass
class AngelInvestorRepresentation:
    """AngelInvestor data representation."""

    name: str
    email: str
    website: str
    country: str
    founding_date: datetime.date
    description: str
    industries: List[str]
    sectors: List[str]
    product_types: List[str]
    stage: str
    investment_stage: List[str]
    min_investment_size: int
    max_investment_size: int
    is_product_on_market: bool
    business_type: str
    phone_number: Optional[PhoneNumber] = None
    logotype: Optional[str] = None
