# k8s-openresty-php

> A set of relatively clean but full-featured, split solution to running openresty and php-fpm together but in seperate containers, supporting PHP versions 5.6, 7.1, 7.2, 7.3, 7.4, 8.0, and 8.1 maintained by [Parallax](https://parall.ax/)

## Docker Tags 
|openresty      | Docker tag                                      |
| ------------- | -------------                                   |
| 1.15.8.2      | prlx/k8s-openresty-php-openresty:release-latest |

| PHP           | Docker Tag                                          |
| ------------- | -------------                                       |
| 5.6           | prlx/k8s-openresty-php-php:release-php-5.6-latest   |
| 7.1           | prlx/k8s-openresty-php-php:release-php-7.1-latest   |
| 7.2           | prlx/k8s-openresty-php-php:release-php-7.2-latest   |
| 7.3           | prlx/k8s-openresty-php-php:release-php-7.3-latest   |
| 7.4           | prlx/k8s-openresty-php-php:release-php-7.4-latest   |
| 8.0           | prlx/k8s-openresty-php-php:release-php-8.0-latest   |
| 8.1           | prlx/k8s-openresty-php-php:release-php-8.1-latest   |

## Browse all tags on Docker Hub
[Openresty](https://hub.docker.com/r/prlx/k8s-openresty-php-openresty)

[PHP](https://hub.docker.com/r/prlx/k8s-openresty-php-php)

# Environment Variables

These containers work with certain environment variables to control their operation. Environment variables marked as required may be omitted and things may seem to work OK but we do not test against omitting these so you may see some pretty interesting behaviour as a result.

Web/Worker just means whether these have any effect - nothing bad will happen if they are set on both.

For help running these locally with docker run see the [docker run reference](https://docs.docker.com/engine/reference/run/#env-environment-variables)

| Key                             | Description                                                                                                     | Required | Web | Worker |
| ---                             | ---                                                                                                             | ---      | --- | ---    |
| SITE_NAME                       | The name of your project, i.e. 'mywebsite'. Used by NR for app name.                                            | ✓        | ✓   | ✓      |
| SITE_BRANCH                     | The running branch of your project, i.e. 'master'. Used by NR for app name.                                     | ✓        | ✓   | ✓      |
| ENVIRONMENT                     | The environment you're running in, i.e. 'qa' or 'production'. Used by NR for app name.                          | ✓        | ✓   | ✓      |
| ATATUS_APM_LICENSE_KEY          | Your Atatus license key. Atatus won't be used if this is not set.                                               | ✖        | ✓   | ✓      |
| ATATUS_FRAMEWORK                | Manually set the Atatus framework (see Atatus docs, typically "Laravel" or "Symfony")                           | ✖        | ✓   | ✓      |
| ATATUS_APM_RAW_SQL              | Set to any value (1, true, etc) to use raw sql logging into Atatus                                              | ✖        | ✓   | ✓      |
| PHP_MEMORY_MAX                  | Maximum PHP request memory, in megabytes (i.e. '256'). Defaults to 128.                                         | ✖        | ✓   | ✓      |
| MAX_EXECUTION_TIME              | Maximum PHP and Nginx execution/fastcgi read timeout	                                                          | ✖        | ✓   | ✓      |
| PHP_FPM_WORKERS                 | Maximum PHP-FPM workers. Defaults to 4 if not set.                                                              | ✖        | ✓   | ✖      |
| PHP_FPM_USER                    | User which PHP-FPM workers are started as. Defaults to nobody.                                                  | ✖        | ✓   | ✖      |
| PHP_FPM_GROUP                   | Group which PHP-FPM workers are started as. Defaults to nobody.                                                 | ✖        | ✓   | ✖      |
| DISABLE_OPCACHE                 | Set to any value (1, true, etc) to disable PHP Opcache                                                          | ✖        | ✓   | ✓      |
| PHP_OPCACHE_MEMORY              | Maximum PHP request memory, in megabytes (i.e. '64'). Defaults to 16.                                           | ✖        | ✓   | ✓      |
| PHP_SESSION_STORE               | If not set, PHP uses /tmp for sessions. If set to 'redis', uses redis for sessions                              | ✖        | ✓   | ✓      |
| PHP_SESSION_STORE_REDIS_HOST    | If not set, defaults to 'redis'. Only used if PHP_SESSION_STORE is set to redis                                 | ✖        | ✓   | ✓      |
| PHP_SESSION_STORE_REDIS_PORT    | If not set, defaults to 6379. Only used if PHP_SESSION_STORE is set to redis                                    | ✖        | ✓   | ✓      |
| PHP_DISABLE_CACHE_HEADERS       | Set to any value (1, true, etc) to disable PHP's default pragma: no-cache headers                               | ✖        | ✓   | ✖      |
| PHP_ENABLE_SHORT_TAGS           | Set to any value (1, true, etc) to enable PHP short tagging                                                     | ✖        | ✓   | ✓      |

# The web mode/command

The web mode is what you use to run a web server - unless you're using workers this is the only one you'll be using. It runs all the things you need to be able to run a PHP-FPM container in Kubernetes.

It is also the default behaviour for the docker containers meaning you don't need to specify a command or working directory to run.

## Ports and Services

| Service                                                                                  | Description                                             | Port/Socket         |
| -------------                                                                            | -------------                                           | -------------       |
| [Openresty](https://openresty.org/)                                                      | Web server                                              | 0.0.0.0:80          |
| [PHP-FPM](https://php-fpm.org/)                                                          | PHP running as a pool of workers                        | 127.0.0.1:9000       |

## K8s Example

### deployment.yaml
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    cluster-autoscaler.kubernetes.io/safe-to-evict: "true"
  labels:
    app: 'k8s-openresty-php-74-test'
  name: 'k8s-openresty-php-74-test'
  namespace: k8s-openresty-php
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 1
  selector:
    matchLabels:
      app: 'k8s-openresty-php-74-test'
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
    type: RollingUpdate
  template:
    metadata:
      annotations:
        cluster-autoscaler.kubernetes.io/safe-to-evict: "true"
      labels:
        app: 'k8s-openresty-php-74-test'
    spec:
      volumes:
        - name: shared-files
          emptyDir: {}
        - name: uploads
          emptyDir: {}
      containers:
      - name: php
        image: '{{ PHP7.4IMAGEHERE }}'
        imagePullPolicy: IfNotPresent
        livenessProbe:
          failureThreshold: 1
          exec:
            command:
            - /healthcheck.sh
            - --listen-queue=10 # fails if there are more than 10 processes waiting in the fpm queue
          initialDelaySeconds: 10
          periodSeconds: 10
          successThreshold: 1
          timeoutSeconds: 5
        readinessProbe:
          failureThreshold: 1
          exec:
            command:
            - /healthcheck.sh
          initialDelaySeconds: 10
          periodSeconds: 10
          successThreshold: 1
          timeoutSeconds: 5
        resources:
          limits:
            cpu: "1"
            memory: 512Mi
          requests:
            cpu: 50m
            memory: 64Mi
        volumeMounts:
          - name: shared-files
            mountPath: /src-shared
          - name: uploads
            mountPath: /var/nginx-uploads
      - name: openresty
        image: '{{ OPENRESTYIMAGEHERE }}'
        imagePullPolicy: IfNotPresent
        livenessProbe:
          failureThreshold: 3
          httpGet:
            path: /healthz
            port: openresty
            scheme: HTTP
          initialDelaySeconds: 10
          periodSeconds: 10
          successThreshold: 1
          timeoutSeconds: 1
        readinessProbe:
          failureThreshold: 3
          httpGet:
            path: /healthz
            port: openresty
            scheme: HTTP
          initialDelaySeconds: 10
          periodSeconds: 5
          successThreshold: 2
          timeoutSeconds: 2
        ports:
        - containerPort: 80
          name: openresty
          protocol: TCP
        resources:
          limits:
            cpu: "1"
            memory: 512Mi
          requests:
            cpu: 50m
            memory: 64Mi
        volumeMounts:
          - name: shared-files
            mountPath: /src-shared
          - name: uploads
            mountPath: /var/nginx-uploads
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      terminationGracePeriodSeconds: 20
```
### service.yaml
```yaml
apiVersion: v1
kind: Service
metadata:
  name: 'openresty-74-test'
  namespace: k8s-openresty-php
spec:
  ports:
  - name: openresty
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: 'k8s-openresty-php-74-test'
  sessionAffinity: None
  type: ClusterIP
```

# Custom Startup Scripts

You can add behaviour to the built-in startup scripts for web, worker or both modes by adding a file to:

| File Path          | Runs on |
| ---                | ---     |
| /start.sh          | Web     |
| /start-worker.sh   | Worker  |
| /start-cron.sh     | Cron    |

# The worker mode/command

The worker will run php artisan queue:work --timeout=$WORKER_TIMEOUT --tries=$WORKER_TRIES.

To run in this mode, change the Docker CMD to be /start-worker.sh instead of the default /start-web.sh.

# PHP Modules
| Module | 5.6 | 7.1 | 7.2 | 7.3 | 7.4 | 8.0 | 8.1 |
| --- | --- | --- | --- | --- | --- | --- | --- |
|  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| apc | ✓ | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ |
| apcu | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| atatus | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✖ |
| bcmath | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| bz2 | ✖ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| calendar | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| Core | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| ctype | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| curl | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| date | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| dom | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| ereg | ✓ | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ |
| exif | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| fileinfo | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| filter | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| ftp | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| gd | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| gettext | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| hash | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| iconv | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| igbinary | ✖ | ✖ | ✖ | ✖ | ✓ | ✓ | ✓ |
| imagick | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| intl | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| json | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| ldap | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| libxml | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| mbstring | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| mcrypt | ✓ | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ |
| memcached | ✖ | ✓ | ✓ | ✓ | ✓ | ✖ | ✖ |
| mysql | ✓ | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ |
| mysqli | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| mysqlnd | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| openssl | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| pcntl | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| pcre | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| PDO | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| pdo_mysql | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| pdo_sqlite | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| Phar | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| phpdbg_webhelper | ✖ | ✓ | ✓ | ✓ | ✖ | ✖ | ✖ |
| posix | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| readline | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| redis | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| Reflection | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| session | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| shmop | ✖ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| SimpleXML | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| soap | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| sockets | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| sodium | ✖ | ✖ | ✖ | ✖ | ✖ | ✖ | ✓ |
| SPL | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| sqlite3 | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| standard | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| sysvmsg | ✖ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| sysvsem | ✖ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| sysvshm | ✖ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| tidy | ✖ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| tokenizer | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| wddx | ✓ | ✓ | ✓ | ✓ | ✖ | ✖ | ✖ |
| xml | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| xmlreader | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| xmlrpc | ✓ | ✓ | ✓ | ✓ | ✓ | ✖ | ✖ |
| xmlwriter | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| xsl | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| Zend OPcache | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| zip | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| zlib | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
