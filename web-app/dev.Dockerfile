FROM node:carbon

WORKDIR /web-app

COPY yarn.lock yarn.lock
COPY package.json package.json

RUN yarn

COPY . .