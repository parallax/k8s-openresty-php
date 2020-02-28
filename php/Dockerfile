FROM alpine:3.9

ARG PHP_VERSION=7.3
ARG ATATUS_VERSION=1.8.0
ARG ATATUS_ENABLED=TRUE

ENV \
    # When using Composer, disable the warning about running commands as root/super user
    COMPOSER_ALLOW_SUPERUSER=1 \
    # Persistent runtime dependencies
    DEPS="php$PHP_VERSION \
        php$PHP_VERSION-phar \
        php$PHP_VERSION-bcmath \
        php$PHP_VERSION-calendar \
        php$PHP_VERSION-mbstring \
        php$PHP_VERSION-exif \
        php$PHP_VERSION-ftp \
        php$PHP_VERSION-openssl \
        php$PHP_VERSION-zip \
        php$PHP_VERSION-sysvsem \
        php$PHP_VERSION-sysvshm \
        php$PHP_VERSION-sysvmsg \
        php$PHP_VERSION-shmop \
        php$PHP_VERSION-sockets \
        php$PHP_VERSION-zlib \
        php$PHP_VERSION-bz2 \
        php$PHP_VERSION-curl \
        php$PHP_VERSION-simplexml \
        php$PHP_VERSION-xml \
        php$PHP_VERSION-opcache \
        php$PHP_VERSION-dom \
        php$PHP_VERSION-xmlreader \
        php$PHP_VERSION-xmlwriter \
        php$PHP_VERSION-tokenizer \
        php$PHP_VERSION-ctype \
        php$PHP_VERSION-gd \
        php$PHP_VERSION-gettext \
        php$PHP_VERSION-imagick \
        php$PHP_VERSION-intl \
        php$PHP_VERSION-ldap \
        php$PHP_VERSION-intl \
        php$PHP_VERSION-memcached \
        php$PHP_VERSION-mysqli \
        php$PHP_VERSION-mysqlnd \
        php$PHP_VERSION-pcntl \
        php$PHP_VERSION-pdo \
        php$PHP_VERSION-pdo_mysql \
        php$PHP_VERSION-pdo_sqlite \
        php$PHP_VERSION-redis \
        php$PHP_VERSION-soap \
        php$PHP_VERSION-sqlite3 \
        php$PHP_VERSION-tidy \
        php$PHP_VERSION-tokenizer \
        php$PHP_VERSION-wddx \
        php$PHP_VERSION-xsl \
        php$PHP_VERSION-session \
        php$PHP_VERSION-fileinfo \
        php$PHP_VERSION-iconv \
        php$PHP_VERSION-json \
        php$PHP_VERSION-posix \
        php$PHP_VERSION-xmlrpc \
        php$PHP_VERSION-fpm \
        php$PHP_VERSION-apcu \
        curl \
        ca-certificates \
        supervisor \
        bash \
        tzdata \
        openssl \
        wget \
        curl \
        bash"

# Install deps
RUN apk add --no-cache \
	curl \
    ca-certificates \
    supervisor \
    bash \
    tzdata \
    openssl \
    wget \
    curl \
    bash \
    fcgi

RUN if [ "$PHP_VERSION" == "7.1" ]; then \

	# PHP.earth Alpine repository for better developer experience
	wget https://repos.php.earth/alpine/phpearth.rsa.pub -O /etc/apk/keys/phpearth.rsa.pub \
	
	&& set -x && \
   	echo "https://repos.php.earth/alpine/v3.9" >> /etc/apk/repositories \

	&& apk add --no-cache \ 
		php$PHP_VERSION \
		php$PHP_VERSION-phar \
		php$PHP_VERSION-bcmath \
		php$PHP_VERSION-calendar \
		php$PHP_VERSION-mbstring \
		php$PHP_VERSION-exif \
		php$PHP_VERSION-ftp \
		php$PHP_VERSION-openssl \
		php$PHP_VERSION-zip \
		php$PHP_VERSION-sysvsem \
		php$PHP_VERSION-sysvshm \
		php$PHP_VERSION-sysvmsg \
		php$PHP_VERSION-shmop \
		php$PHP_VERSION-sockets \
		php$PHP_VERSION-zlib \
		php$PHP_VERSION-bz2 \
		php$PHP_VERSION-curl \
		php$PHP_VERSION-simplexml \
		php$PHP_VERSION-xml \
		php$PHP_VERSION-opcache \
		php$PHP_VERSION-dom \
		php$PHP_VERSION-xmlreader \
		php$PHP_VERSION-xmlwriter \
		php$PHP_VERSION-tokenizer \
		php$PHP_VERSION-ctype \
		php$PHP_VERSION-gd \
		php$PHP_VERSION-gettext \
		php$PHP_VERSION-imagick \
		php$PHP_VERSION-intl \
		php$PHP_VERSION-ldap \
		php$PHP_VERSION-intl \
		php$PHP_VERSION-memcached \
		php$PHP_VERSION-mysqli \
		php$PHP_VERSION-mysqlnd \
		php$PHP_VERSION-pcntl \
		php$PHP_VERSION-pdo \
		php$PHP_VERSION-pdo_mysql \
		php$PHP_VERSION-pdo_sqlite \
		php$PHP_VERSION-redis \
		php$PHP_VERSION-soap \
		php$PHP_VERSION-sqlite3 \
		php$PHP_VERSION-tidy \
		php$PHP_VERSION-tokenizer \
		php$PHP_VERSION-wddx \
		php$PHP_VERSION-xsl \
		php$PHP_VERSION-session \
		php$PHP_VERSION-fileinfo \
		php$PHP_VERSION-iconv \
		php$PHP_VERSION-json \
		php$PHP_VERSION-posix \
		php$PHP_VERSION-xmlrpc \
		php$PHP_VERSION-fpm \
		php$PHP_VERSION-apcu && \

	# Symlink current version
	ln -snf /etc/php/$PHP_VERSION /etc/php/current; \
	
	fi

RUN if [ "$PHP_VERSION" == "7.2" ]; then \

	# PHP.earth Alpine repository for better developer experience
	wget https://repos.php.earth/alpine/phpearth.rsa.pub -O /etc/apk/keys/phpearth.rsa.pub && \
	
	set -x \
    && echo "https://repos.php.earth/alpine/v3.9" >> /etc/apk/repositories && \

	apk add --no-cache \ 
		php$PHP_VERSION \
		php$PHP_VERSION-phar \
		php$PHP_VERSION-bcmath \
		php$PHP_VERSION-calendar \
		php$PHP_VERSION-mbstring \
		php$PHP_VERSION-exif \
		php$PHP_VERSION-ftp \
		php$PHP_VERSION-openssl \
		php$PHP_VERSION-zip \
		php$PHP_VERSION-sysvsem \
		php$PHP_VERSION-sysvshm \
		php$PHP_VERSION-sysvmsg \
		php$PHP_VERSION-shmop \
		php$PHP_VERSION-sockets \
		php$PHP_VERSION-zlib \
		php$PHP_VERSION-bz2 \
		php$PHP_VERSION-curl \
		php$PHP_VERSION-simplexml \
		php$PHP_VERSION-xml \
		php$PHP_VERSION-opcache \
		php$PHP_VERSION-dom \
		php$PHP_VERSION-xmlreader \
		php$PHP_VERSION-xmlwriter \
		php$PHP_VERSION-tokenizer \
		php$PHP_VERSION-ctype \
		php$PHP_VERSION-gd \
		php$PHP_VERSION-gettext \
		php$PHP_VERSION-imagick \
		php$PHP_VERSION-intl \
		php$PHP_VERSION-ldap \
		php$PHP_VERSION-intl \
		php$PHP_VERSION-memcached \
		php$PHP_VERSION-mysqli \
		php$PHP_VERSION-mysqlnd \
		php$PHP_VERSION-pcntl \
		php$PHP_VERSION-pdo \
		php$PHP_VERSION-pdo_mysql \
		php$PHP_VERSION-pdo_sqlite \
		php$PHP_VERSION-redis \
		php$PHP_VERSION-soap \
		php$PHP_VERSION-sqlite3 \
		php$PHP_VERSION-tidy \
		php$PHP_VERSION-tokenizer \
		php$PHP_VERSION-wddx \
		php$PHP_VERSION-xsl \
		php$PHP_VERSION-session \
		php$PHP_VERSION-fileinfo \
		php$PHP_VERSION-iconv \
		php$PHP_VERSION-json \
		php$PHP_VERSION-posix \
		php$PHP_VERSION-xmlrpc \
		php$PHP_VERSION-fpm \
		php$PHP_VERSION-apcu && \

		# Symlink current version
		ln -snf /etc/php/$PHP_VERSION /etc/php/current; \
	fi

RUN if [ "$PHP_VERSION" == "7.3" ]; then \

	# PHP.earth Alpine repository for better developer experience
	wget https://repos.php.earth/alpine/phpearth.rsa.pub -O /etc/apk/keys/phpearth.rsa.pub && \
	
	RUN set -x \
    	&& echo "https://repos.php.earth/alpine/v3.9" >> /etc/apk/repositories && \

	apk add --no-cache \ 
		php$PHP_VERSION \
		php$PHP_VERSION-phar \
		php$PHP_VERSION-bcmath \
		php$PHP_VERSION-calendar \
		php$PHP_VERSION-mbstring \
		php$PHP_VERSION-exif \
		php$PHP_VERSION-ftp \
		php$PHP_VERSION-openssl \
		php$PHP_VERSION-zip \
		php$PHP_VERSION-sysvsem \
		php$PHP_VERSION-sysvshm \
		php$PHP_VERSION-sysvmsg \
		php$PHP_VERSION-shmop \
		php$PHP_VERSION-sockets \
		php$PHP_VERSION-zlib \
		php$PHP_VERSION-bz2 \
		php$PHP_VERSION-curl \
		php$PHP_VERSION-simplexml \
		php$PHP_VERSION-xml \
		php$PHP_VERSION-opcache \
		php$PHP_VERSION-dom \
		php$PHP_VERSION-xmlreader \
		php$PHP_VERSION-xmlwriter \
		php$PHP_VERSION-tokenizer \
		php$PHP_VERSION-ctype \
		php$PHP_VERSION-gd \
		php$PHP_VERSION-gettext \
		php$PHP_VERSION-imagick \
		php$PHP_VERSION-intl \
		php$PHP_VERSION-ldap \
		php$PHP_VERSION-intl \
		php$PHP_VERSION-memcached \
		php$PHP_VERSION-mysqli \
		php$PHP_VERSION-mysqlnd \
		php$PHP_VERSION-pcntl \
		php$PHP_VERSION-pdo \
		php$PHP_VERSION-pdo_mysql \
		php$PHP_VERSION-pdo_sqlite \
		php$PHP_VERSION-redis \
		php$PHP_VERSION-soap \
		php$PHP_VERSION-sqlite3 \
		php$PHP_VERSION-tidy \
		php$PHP_VERSION-tokenizer \
		php$PHP_VERSION-wddx \
		php$PHP_VERSION-xsl \
		php$PHP_VERSION-session \
		php$PHP_VERSION-fileinfo \
		php$PHP_VERSION-iconv \
		php$PHP_VERSION-json \
		php$PHP_VERSION-posix \
		php$PHP_VERSION-xmlrpc \
		php$PHP_VERSION-fpm \
		php$PHP_VERSION-apcu && \

		# Symlink current version
		ln -snf /etc/php/$PHP_VERSION /etc/php/current; \
	fi

RUN if [ "$PHP_VERSION" == "7.4" ]; then \

	# Codecasts PHP repow
	wget https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub -O /etc/apk/keys/php-alpine.rsa.pub && \
	
	set -x \
	&& echo "https://dl.bintray.com/php-alpine/v3.9/php-7.4" >> /etc/apk/repositories && \

	apk add --no-cache \ 
		php \
		php-phar \
		php-bcmath \
		php-calendar \
		php-mbstring \
		php-exif \
		php-ftp \
		php-openssl \
		php-zip \
		php-sysvsem \
		php-sysvshm \
		php-sysvmsg \
		php-shmop \
		php-sockets \
		php-zlib \
		php-bz2 \
		php-curl \
		php-xml \
		php-opcache \
		php-dom \
		php-xmlreader \
		php-ctype \
		php-gd \
		php-gettext \
		php-imagick \
		php-intl \
		php-ldap \
		php-intl \
		php-memcached \
		php-mysqli \
		php-mysqlnd \
		php-pcntl \
		php-pdo \
		php-pdo_mysql \
		php-pdo_sqlite \
		php-redis \
		php-soap \
		php-sqlite3 \
		php-tidy \
		php-xsl \
		php-session \
		php-iconv \
		php-json \
		php-posix \
		php-xmlrpc \
		php-fpm \
		php-apcu && \

	ln -snf /usr/bin/php7 /usr/bin/php && \
	ln -snf /usr/sbin/php-fpm7 /usr/sbin/php-fpm && \


	# Symlink current version
	mkdir -p /etc/php/current && \
	ln -snf /etc/php7 /etc/php/current; \

	fi

# Composer
RUN EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)" && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")" && \
    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; \
    then \
        >&2 echo 'ERROR: Invalid installer signature' \
        rm composer-setup.php \
    exit 1; \
    fi && \
    php composer-setup.php --quiet --install-dir=/usr/local/bin --filename=composer && \
    RESULT=$? && \
    rm composer-setup.php && \
    exit $RESULT

RUN if [ "$ATATUS_ENABLED" == "TRUE" ]; then \
	# Atatus
	wget https://s3.amazonaws.com/atatus-artifacts/atatus-php/downloads/atatus-php-$ATATUS_VERSION-x64-musl.tar.gz && tar -xzvf atatus-php-$ATATUS_VERSION-x64-musl.tar.gz && cd atatus-php-$ATATUS_VERSION-x64-musl && ./install.sh && rm -f /atatus-php-$ATATUS_VERSION-x64-musl.tar.gz && rm -rf /atatus-php-$ATATUS_VERSION-x64-musl && \
	sed -i -e 's#atatus.trace.response_time = 2000#atatus.trace.response_time = 1500#g' /etc/php/$PHP_VERSION/conf.d/atatus.ini && \
	  sed -i -e 's#atatus.collector.pidfile = "/var/run/atatus-php-collector.pid"#atatus.collector.pidfile = "/run/atatus-php-collector.pid"#g' /etc/php/$PHP_VERSION/conf.d/atatus.ini && \
	  sed -i -e 's#atatus.collector.connection = "/tmp/.atatus.sock"#atatus.collector.connection = "/run/atatus.sock"#g' /etc/php/$PHP_VERSION/conf.d/atatus.ini && \
	# Write log files to stdout
	rm -f /var/log/atatus/agent.log && rm -f /var/log/atatus/collector.log && rm -f /var/log/atatus/debug.txt && ln -sf /dev/null /var/log/atatus/agent.log && ln -sf /dev/null /var/log/atatus/collector.log && ln -sf /dev/null /var/log/atatus/debug.txt; \
	fi

# PHP Config
ADD /php/conf/php-fpm.conf /etc/php/current/php-fpm.conf
ADD /php/conf/php.ini /etc/php/current/php.ini
ADD /php/conf/php-www.conf /etc/php/current/php-fpm.d/www.conf

# Clear out garbage
RUN unset DEPS && rm -rf /run/php && rm -rf /run/php-fpm7.3

# Start script
ADD /php/scripts/start.sh /start.sh
RUN chmod +x /start.sh

# Start cron script
ADD /php/scripts/start-cron.sh /start-cron.sh
RUN chmod +x /start-cron.sh

# Start worker script
ADD /php/scripts/start-worker.sh /start-worker.sh
RUN chmod +x /start-worker.sh

# Configure script
ADD /php/scripts/configure.sh /configure.sh
RUN chmod +x /configure.sh

# Healthcheck script
ADD /php/scripts/healthcheck.sh /healthcheck.sh
RUN chmod +x /healthcheck.sh

CMD ["/start.sh"]