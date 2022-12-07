#!/bin/bash
set -eo pipefail
source /configure.sh

cp -R /src/. /src-shared/
rm -rf /src
chown -R nobody:nobody /src-shared

if [ -n "$EXPOSE_CLASSIC" ]; then
	ln -s /src-shared/ /src
fi

echo "Starting Cron"
/usr/sbin/crond -f -c /etc/cron
