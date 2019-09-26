#!/bin/bash
# If stuff hasn't been set
if [ -z "$SITE_NAME" ]; then
	export SITE_NAME=site_name
fi
if [ -z "$SITE_BRANCH" ]; then
	export SITE_BRANCH=site_branch
fi
if [ -z "$ENVIRONMENT" ]; then
	export ENVIRONMENT=site_environment
fi

# Container info:
printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "Site:" "$SITE_NAME"
printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "Branch:" "$SITE_BRANCH"
printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "Environment:" "$ENVIRONMENT"

# Version numbers:
printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "PHP Version:" "`php -r 'echo phpversion();'`"

# Atatus - if api key is set then configure and enable
if [ ! -z "$ATATUS_APM_LICENSE_KEY" ] && [ "$ATATUS_APM_LICENSE_KEY" != "test" ]; then

    # Enabled
    printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "Atatus:" "Enabled"

    # Set the atatus api key
    sed -i -e "s/atatus.license_key = \"\"/atatus.license_key = \"$ATATUS_APM_LICENSE_KEY\"/g" /etc/php/current/conf.d/atatus.ini

    # Set the release stage to be the environment
    sed -i -e "s/atatus.release_stage = \"production\"/atatus.release_stage = \"$ENVIRONMENT\"/g" /etc/php/current/conf.d/atatus.ini

    # Set the app name to be site_name environment
    sed -i -e "s/atatus.app_name = \"PHP App\"/atatus.app_name = \"$SITE_NAME\"/g" /etc/php/current/conf.d/atatus.ini

    # Set the app version to be the branch build
    sed -i -e "s/atatus.app_version = \"\"/atatus.app_version = \"$SITE_BRANCH-$BUILD\"/g" /etc/php/current/conf.d/atatus.ini

    # Set the tags to contain useful data
    sed -i -e "s/atatus.tags = \"\"/atatus.tags = \"$SITE_BRANCH-$BUILD, $SITE_BRANCH\"/g" /etc/php/current/conf.d/atatus.ini

   	# Atatus - configure raw sql logs if desirable
	if [ ! -z "$ATATUS_APM_RAW_SQL" ]; then
	
	    # Enabled
	    printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "Atatus SQL:" "Raw"
	
	    # Set the atatus api key
	    sed -i -e "s/atatus.sql.capture = \"normalized\"/atatus.sql.capture = \"raw\"/g" /etc/php/current/conf.d/atatus.ini
	
	fi
	
	# Atatus - configure laravel queues if desirable
	if [ -z "$ATATUS_APM_DISABLE_LARAVEL_QUEUES" ]; then
	
	    # Enabled
	    printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "Atatus Laravel Queues:" "Enabled"
	
	    # Set the atatus api key
	    sed -i -e "s/atatus.laravel.enable_queues = false/atatus.laravel.enable_queues = true/g" /etc/php/current/conf.d/atatus.ini
	else
		# Disabled
	    printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "Atatus Laravel Queues:" "Disabled"
	fi

fi

# Atatus - if api key is not set then disable
if [ -z "$ATATUS_APM_LICENSE_KEY" ] && [ "$ATATUS_APM_LICENSE_KEY" != "test" ]; then

    # Disabled
    printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "Atatus:" "Disabled"
    rm -f /etc/php/current/conf.d/atatus.ini

fi

# Whether to send cache headers automatically for PHP scripts
if [ ! -z "$PHP_DISABLE_CACHE_HEADERS" ]; then
    sed -i -e "s#session.cache_limiter = nocache#session.cache_limiter = ''#g" /etc/php/current/php.ini
fi

# PHP Max Memory
# If set
if [ ! -z "$PHP_MEMORY_MAX" ]; then
    
    # Set PHP.ini accordingly
    sed -i -e "s#memory_limit = 128M#memory_limit = ${PHP_MEMORY_MAX}M#g" /etc/php/current/php.ini

fi

# Print the real value
printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "PHP Memory Max:" "`php -r 'echo ini_get("memory_limit");'`"

# PHP Opcache
# If not set
if [ -z "$DISABLE_OPCACHE" ]; then
    
    printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "PHP Opcache:" "Enabled"

fi
# If set
if [ ! -z "$DISABLE_OPCACHE" ]; then
    
    printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "PHP Opcache:" "Disabled"
    
    # Set PHP.ini accordingly
    sed -i -e "s#opcache.enable=1#opcache.enable=0#g" /etc/php/current/php.ini
    sed -i -e "s#opcache.enable_cli=1#opcache.enable_cli=0#g" /etc/php/current/php.ini

fi

# PHP Opcache Memory
# If set
if [ ! -z "$PHP_OPCACHE_MEMORY" ]; then
    
    # Set PHP.ini accordingly
    sed -i -e "s#opcache.memory_consumption=16#opcache.memory_consumption=${PHP_OPCACHE_MEMORY}#g" /etc/php/current/php.ini

fi

# Print the real value
printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "Opcache Memory Max:" "`php -r 'echo ini_get("opcache.memory_consumption");'`M"

# PHP Session Config
# If set
if [ ! -z "$PHP_SESSION_STORE" ]; then
    
    # Figure out which session save handler is in use, currently only supports redis
    if [ $PHP_SESSION_STORE == 'redis' ] || [ $PHP_SESSION_STORE == 'REDIS' ]; then
        if [ -z $PHP_SESSION_STORE_REDIS_HOST ]; then
            PHP_SESSION_STORE_REDIS_HOST='redis'
        fi
        if [ -z $PHP_SESSION_STORE_REDIS_PORT ]; then
            PHP_SESSION_STORE_REDIS_PORT='6379'
        fi
        printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "PHP Sessions:" "Redis"
        printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "PHP Redis Host:" "$PHP_SESSION_STORE_REDIS_HOST"
        printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "PHP Redis Port:" "$PHP_SESSION_STORE_REDIS_PORT"
        sed -i -e "s#session.save_handler = files#session.save_handler = redis\nsession.save_path = \"tcp://$PHP_SESSION_STORE_REDIS_HOST:$PHP_SESSION_STORE_REDIS_PORT\"#g" /etc/php/current/php.ini
    fi

fi

# Max Execution Time
# If set
if [ ! -z "$MAX_EXECUTION_TIME" ]; then
    
    # Set PHP.ini accordingly
    sed -i -e "s#max_execution_time = 600#max_execution_time = ${MAX_EXECUTION_TIME}#g" /etc/php/current/php.ini

fi

# Print the value
printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "PHP Max Execution Time:" "`cat /etc/php/current/php.ini | grep 'max_execution_time = ' | sed -e 's/max_execution_time = //g'`"

# PHP-FPM Max Workers
# If set
if [ ! -z "$PHP_FPM_WORKERS" ]; then
        
    # Set PHP.ini accordingly
    sed -i -e "s#pm.max_children = 4#pm.max_children = $PHP_FPM_WORKERS#g" /etc/php/current/php-fpm.d/www.conf

fi

printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "PHP-FPM Max Workers:" "`cat /etc/php/current/php-fpm.d/www.conf | grep 'pm.max_children = ' | sed -e 's/pm.max_children = //g'`"

# Enable short tags for older sites
if [ ! -z "$PHP_ENABLE_SHORT_TAGS" ]; then
    sed -i -e 's/short_open_tag = Off/short_open_tag = On/g' /etc/php/current/php.ini
    printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "PHP Short Tags:" "Enabled"
else
	printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "PHP Short Tags:" "Disabled"
fi

# Set SMTP settings
if [ "$ENVIRONMENT" == 'production' ]; then
    
    if [ -z "$MAIL_HOST" ]; then
        export MAIL_HOST=master-smtp.smtp-production
    fi
fi

if [ "$ENVIRONMENT" == 'qa' ] || [ -z "$ENVIRONMENT" ]; then
    
    if [ -z "$MAIL_HOST" ]; then
        export MAIL_HOST=master-smtp.mailhog-production
    fi
fi

if [ -z "$MAIL_DRIVER" ]; then
    export MAIL_DRIVER=mail
fi

if [ -z "$MAIL_PORT" ]; then
    export MAIL_PORT=25
fi

printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "MAIL_HOST:" "$MAIL_HOST"
printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "MAIL_PORT:" "$MAIL_PORT"
printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "MAIL_DRIVER:" "$MAIL_DRIVER"
printf "\e[94m%-30s\e[0m \e[35m%-30s\e[0m\n" "MAIL_DRIVER:" "$MAIL_DRIVER"

cp -R /src/. /src-shared/
rm -rf /src
chown -R nobody:nobody /src-shared