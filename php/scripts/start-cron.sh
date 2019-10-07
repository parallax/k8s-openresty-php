#!/bin/bash
source /configure.sh

cp -R /src/. /src-shared/
rm -rf /src
chown -R nobody:nobody /src-shared

/usr/sbin/crond -f -c /etc/cron