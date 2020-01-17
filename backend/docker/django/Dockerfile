# This Dockerfile uses multi-stage build to customize DEV and PROD images:
# https://docs.docker.com/develop/develop-images/multistage-build/

FROM python:3.7.4-alpine3.9 as development_build

ENV \
  # python:
  PYTHONFAULTHANDLER=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONHASHSEED=random \
  # pip:
  PIP_NO_CACHE_DIR=off \
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  PIP_DEFAULT_TIMEOUT=100 \
  # dockerize:
  DOCKERIZE_VERSION=v0.6.1 \
  # poetry:
  POETRY_VERSION=1.0.0

# Build deps:
RUN apk add --no-cache --virtual .build-deps \
  build-base \
  gcc \
  git \
  libffi-dev \
  linux-headers \
  openssl \
  musl-dev \
  postgresql-dev

# Pillow dependencies
RUN apk add --no-cache \
  jpeg-dev \
  zlib-dev \
  libjpeg \
  libpq \
  gettext \
  tini 

# Installing `poetry` package manager:
# https://github.com/sdispater/poetry
RUN pip install "poetry==$POETRY_VERSION" \
  # Installing `dockerize` utility:
  # https://github.com/jwilder/dockerize
  && wget "https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz" \
  && tar -C /usr/local/bin -xzvf "dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz" \
  && rm "dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz"

# Copy only requirements, to cache them in docker layer:
WORKDIR /pysetup
COPY ./poetry.lock ./pyproject.toml /pysetup/

# This is a special case. We need to run this script as an entry point:
COPY ./docker/django/entrypoint.sh /docker-entrypoint.sh

# Project initialization:
ARG DJANGO_ENV
ENV DJANGO_ENV=${DJANGO_ENV}

RUN chmod +x "/docker-entrypoint.sh" \
  && poetry config virtualenvs.create false \
  && poetry install $(test "$DJANGO_ENV" == production && echo "--no-dev") --no-interaction --no-ansi

RUN apk del .build-deps

# This dir will become the mountpoint of development code:
WORKDIR /code

ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]


# The following stage is only for Prod:
# https://wemake-django-template.readthedocs.io/en/latest/pages/template/production.html

FROM development_build as production_build

COPY . /code

RUN python /code/manage.py compilemessages
