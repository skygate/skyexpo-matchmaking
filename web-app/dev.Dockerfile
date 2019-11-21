FROM node:carbon

WORKDIR /

COPY yarn.lock yarn.lock
COPY package.json package.json

RUN yarn

COPY . /
