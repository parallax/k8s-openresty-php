#!/bin/bash
BUILDNUMBER=$bamboo_buildNumber

sed -i -e "s#{{ BUILDNUMBER }}#$BUILDNUMBER#g" test/Dockerfile-8.0
docker buildx build --push --platform linux/arm64/v8,linux/amd64 -t prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-8.0-test -f test/Dockerfile-8.0 .