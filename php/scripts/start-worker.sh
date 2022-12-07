#!/bin/bash
set -eo pipefail
source /configure.sh

cp -R /src/. /src-shared/
rm -rf /src
chown -R nobody:nobody /src-shared

cd /src-shared

# Consume any env vars passed in
if [ -z "$WORKER_TIMEOUT" ]; then
	export WORKER_TIMEOUT=1800
fi
if [ -z "$WORKER_TRIES" ]; then
	export WORKER_TRIES=3
fi
if [ -n "$EXPOSE_CLASSIC" ]; then
	ln -s /src-shared/ /src
fi

php artisan queue:work --timeout=$WORKER_TIMEOUT --tries=$WORKER_TRIES
