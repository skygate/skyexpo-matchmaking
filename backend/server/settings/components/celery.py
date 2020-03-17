# -*- coding: utf-8 -*-

from server.settings.components import config

CELERY_BROKER_URL = 'redis://:{password}@{hostname}:{port}/0'.format(
    password=config('REDIS_PASSWORD'),
    hostname=config('REDIS_HOSTNAME'),
    port=config('REDIS_PORT'),
)
CELERY_RESULT_BACKEND = CELERY_BROKER_URL
