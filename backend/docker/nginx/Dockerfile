FROM nginx:1.17

RUN rm /etc/nginx/conf.d/*

COPY ./docker/nginx/nginx.conf /etc/nginx/conf.d/nginx.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.lo
