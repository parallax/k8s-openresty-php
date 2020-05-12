ARG RESTY_IMAGE_BASE="alpine"
ARG RESTY_IMAGE_TAG="3.11"
ARG RESTY_VERSION="1.15.8.3"
ARG NGINX_VERSION="1.15.8"
ARG GEO_DB_RELEASE="2020-04"
ARG ATOMICORP_USER
ARG ATOMICORP_PASS

FROM ${RESTY_IMAGE_BASE}:${RESTY_IMAGE_TAG} as ModSecurity

ARG RESTY_VERSION
ARG NGINX_VERSION

RUN apk add --no-cache --virtual .build-deps \
        build-base \
        coreutils \
        curl \
        gd-dev \
        geoip-dev \
        libxslt-dev \
        linux-headers \
        make \
        perl-dev \
        readline-dev \
        git \
        libtool \
        automake \
        autoconf \
        make \
        gcc \
        lmdb-dev \
        pcre-dev \
        yajl-dev \
        libmaxminddb-dev \
        openssl-dev \
        zlib-dev \
    && apk add --no-cache \
        gd \
        geoip \
        libgcc \
        libxslt \
        zlib \
    && cd /tmp \
    && echo "Installing ModSec Library" \
    && git clone -b v3.0.4 --depth 1 https://github.com/SpiderLabs/ModSecurity \
    && git -C /tmp/ModSecurity submodule update --init --recursive \
    && (cd "/tmp/ModSecurity" && \
        ./build.sh && \
        ./configure --with-lmdb && \
        make && \
        make install \
    )

RUN rm -rf /usr/local/modsecurity/lib/libmodsecurity.la /usr/local/modsecurity/lib/libmodsecurity.a

# Clone Modsec Nginx Connector, GeoIP, and download/extract OpenResty and GeoIP databases
RUN echo 'Cloning Modsec Nginx Connector, GeoIP, and download/extract OpenResty and GeoIP databases' && \
    git clone -b master --depth 1 https://github.com/SpiderLabs/ModSecurity-nginx.git && \
    git clone -b master --depth 1 https://github.com/leev/ngx_http_geoip2_module.git && \
    curl -fSL https://github.com/openresty/openresty/releases/download/v${RESTY_VERSION}/openresty-${RESTY_VERSION}.tar.gz | tar -xz && \
    cd /openresty-${RESTY_VERSION}/bundle/nginx-${NGINX_VERSION} && \
    ./configure --with-compat --add-dynamic-module=/ModSecurity-nginx --add-dynamic-module=/ngx_http_geoip2_module && \
    make modules && \
    mkdir -p /usr/lib/nginx/modules/ && \
    cp objs/ngx_http_modsecurity_module.so /usr/lib/nginx/modules/ngx_http_modsecurity_module.so && \
    cp objs/ngx_http_geoip2_module.so /usr/lib/nginx/modules/ngx_http_geoip2_module.so    

# Get the rules from Atomicorp
FROM ${RESTY_IMAGE_BASE}:${RESTY_IMAGE_TAG} as Atomicorp
ARG ATOMICORP_USER
ARG ATOMICORP_PASS

RUN apk add --no-cache curl bash

RUN export VERSION=`curl -fSLu "${ATOMICORP_USER}:${ATOMICORP_PASS}" https://updates.atomicorp.com/channels/rules/nginx-latest/VERSION | grep MODSEC_VERSION | cut -d '=' -f2` && \
    curl -fSLu "${ATOMICORP_USER}:${ATOMICORP_PASS}" https://updates.atomicorp.com/channels/rules/nginx-latest/nginx-waf-$VERSION.tar.gz | tar -xz

RUN ls -ahls /rules

FROM openresty/openresty:${RESTY_VERSION}-alpine

ARG GEO_DB_RELEASE

RUN apk add --no-cache geoip-dev \
        libgcc \
        libxslt-dev \
        pcre-dev \
        lmdb-dev \
        libmaxminddb-dev \
        yajl-dev \
        bash

COPY --from=ModSecurity /usr/local/modsecurity /usr/local/modsecurity
COPY --from=ModSecurity /usr/lib/nginx/modules/* /usr/local/openresty/nginx/modules/
COPY --from=Atomicorp /rules /etc/nginx/modsec/rules

# Modify the Atomicorp rules
RUN sed -i -e "s#/var/log/nginx/audit_log#/dev/stdout#g" /etc/nginx/modsec/rules/conf/tortix_waf.conf && \
    sed -i -e "s#SecAuditLogType Concurrent#SecAuditLogType Serial#g" /etc/nginx/modsec/rules/conf/tortix_waf.conf && \
    sed -i -e "s#SecRuleEngine on#SecRuleEngine DetectionOnly#g" /etc/nginx/modsec/rules/conf/tortix_waf.conf && \
    echo -en "SecAuditLogFormat json\n" >> /etc/nginx/modsec/rules/conf/tortix_waf.conf && \
    echo -en "SecUnicodeMapFile unicode.mapping 20127\n" >> /etc/nginx/modsec/rules/conf/tortix_waf.conf

# Custom Error Pages
ADD /openresty/error_pages /usr/local/openresty/nginx/html

ADD /openresty/conf/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
ADD /openresty/conf/default.conf /etc/nginx/conf.d/default.conf
ADD /openresty/conf/modsec/unicode.mapping /etc/nginx/modsec/rules/conf/unicode.mapping

# Touch the whitelist file for ASL
RUN mkdir -p /etc/asl && touch /etc/asl/whitelist

# Touch the exclude config that we can subsequently overwrite
RUN touch /whitelist.conf && ln -snf /whitelist.conf /etc/nginx/modsec/rules/00_aaa_whitelist.conf

RUN mkdir -p /usr/local/openresty/geoip && \
    wget -O - https://download.db-ip.com/free/dbip-city-lite-${GEO_DB_RELEASE}.mmdb.gz | gzip -d > /usr/local/openresty/geoip/dbip-city-lite.mmdb && \
    wget -O - https://download.db-ip.com/free/dbip-country-lite-${GEO_DB_RELEASE}.mmdb.gz | gzip -d > /usr/local/openresty/geoip/dbip-country-lite.mmdb

# Add start script
ADD /openresty/start.sh /start.sh
RUN chmod +x /start.sh

# Test for library and config support:
RUN /usr/local/modsecurity/bin/modsec-rules-check 
RUN /usr/local/openresty/bin/openresty -t

# Dummy content
RUN mkdir -p /src-shared/public && apk add --no-cache nano && echo "hello" > /src-shared/public/index.html && chmod 777 /src-shared/public/index.html

CMD ["/start.sh"]