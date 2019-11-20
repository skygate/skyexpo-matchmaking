FROM node:carbon as builder

WORKDIR /web-app

COPY yarn.lock yarn.lock
COPY package.json package.json

RUN yarn

COPY . .

RUN yarn build

FROM nginx

COPY ./nginx.conf /etc/nginx/conf.d/nginx.conf
COPY --from=builder /web-app/public /web-app/public
