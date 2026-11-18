FROM openresty/openresty:1.31.9.1-alpine

RUN apk add --no-cache bash nano

# Custom Error Pages
ADD /openresty/error_pages /usr/local/openresty/nginx/html

ADD /openresty/conf/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
ADD /openresty/conf/default.conf /etc/nginx/conf.d/default.conf