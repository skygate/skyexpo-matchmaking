# -*- coding: utf-8 -*-

from django.contrib import admin
from django.contrib.auth import get_user_model
from django.contrib.auth.models import Group

from server.apps.profile.models import Company, Startup

User = get_user_model()

admin.site.register(User)

admin.site.register(Startup)
admin.site.register(Company)

# Currently we don't use Groups.
admin.site.unregister(Group)
