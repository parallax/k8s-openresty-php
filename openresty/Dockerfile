FROM openresty/openresty:1.15.8.2-1-alpine

RUN apk add --no-cache bash

ADD /openresty/conf/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
ADD /openresty/conf/default.conf /etc/nginx/conf.d/default.conf