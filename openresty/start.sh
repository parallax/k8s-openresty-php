#!/bin/bash
if [ "$MODSEC" == 'true' ]; then
	echo "ModSecurity Enforced"
	sed -i -e "s#SecRuleEngine DetectionOnly#SecRuleEngine on#g" /etc/nginx/modsec/rules/conf/tortix_waf.conf
else
	echo "ModSecurity Not Enforced"
fi
/usr/local/openresty/bin/openresty