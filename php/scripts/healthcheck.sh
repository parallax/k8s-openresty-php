#!/bin/bash

# Check the status of the PHP-FPM Healthcheck:

OUTPUT=`SCRIPT_NAME=/healthz-php \
SCRIPT_FILENAME=/healthz-php \
REQUEST_METHOD=GET \
/usr/bin/cgi-fcgi -bind -connect /run/php.sock`

if [[ $OUTPUT == *"PHP-FPM OK"* ]]; then
	echo "PHP-FPM OK"
	exit
else
	echo "PHP-FPM Error"
	exit 1
fi