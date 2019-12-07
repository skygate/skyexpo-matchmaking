# -*- coding: utf-8 -*-
import datetime
from dataclasses import dataclass
from typing import Dict, List, Optional

from django.core.files.uploadedfile import InMemoryUploadedFile
from phonenumber_field.phonenumber import PhoneNumber


@dataclass
class CompanyRepresentation:
     name: str
     email: str
     website: str
     phone_number: PhoneNumber
     country: str
     founding_date: datetime.date
     description: str
     team_members: List[Dict[str, str]]
     industries: List[str]
     sectors: List[str]
     product_types: List[str]
     stage: str
     investment_stage: List[str]
     min_investment_size: int
     max_investment_size: int
     is_product_on_market: bool
     business_type: str
     logotype: Optional[InMemoryUploadedFile] = None
