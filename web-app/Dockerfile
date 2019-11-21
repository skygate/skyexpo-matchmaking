FROM node:carbon as builder

WORKDIR /

COPY yarn.lock yarn.lock
COPY package.json package.json

RUN yarn

COPY . /

RUN yarn build
