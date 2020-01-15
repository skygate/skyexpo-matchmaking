# -*- coding: utf-8 -*-

from server.settings.components import config

CELERY_BROKER_URL = 'amqp://{username}:{password}@{host}:{port}'.format(
    username=config('RABBITMQ_USERNAME'),
    password=config('RABBITMQ_PASSWORD'),
    host=config('RABBITMQ_HOST'),
    port=config('RABBITMQ_PORT'),
)
# TODO: setup result_backend i inne
