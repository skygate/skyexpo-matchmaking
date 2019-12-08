# -*- coding: utf-8 -*-
import datetime
from dataclasses import dataclass
from typing import Dict, List, Optional

from django.contrib.auth import get_user_model
from django.core.files.uploadedfile import InMemoryUploadedFile
from phonenumber_field.phonenumber import PhoneNumber
from django.utils import timezone
from typing_extensions import final

from server.apps.profile.models import Company

User = get_user_model()


@dataclass()
class UserRepresentation:
    email: str
    is_staff: bool = False
    is_active: bool = True
    password: str = ''


@dataclass()
class ProfileRepresentation:
    name: str
    date_joined: datetime.datetime = timezone.now()
    company: Optional[Company] = None


@dataclass()
class TeamMembersRepresentation:
    team_members: List[Dict[str, str]]


@dataclass()
class CompanyRepresentation:
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
    logotype: Optional[InMemoryUploadedFile] = None
