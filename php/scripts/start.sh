#!/bin/bash
source /configure.sh

cp -R /src/. /src-shared/
rm -rf /src
chown -R nobody:nobody /src-shared

/usr/sbin/php-fpm --nodaemonize --fpm-config /etc/php/current/php-fpm.conf