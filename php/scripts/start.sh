#!/bin/bash
set -eo pipefail
source /configure.sh

cp -R /src/. /src-shared/
rm -rf /src
chown -R nobody:nobody /src-shared

if [ -n "$EXPOSE_CLASSIC" ]; then
	ln -s /src-shared/ /src
fi

/usr/sbin/php-fpm --nodaemonize --fpm-config /etc/php/current/php-fpm.conf
