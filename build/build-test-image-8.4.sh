#!/bin/bash
BUILDNUMBER=$bamboo_buildNumber

sed -i -e "s#{{ BUILDNUMBER }}#$BUILDNUMBER#g" test/Dockerfile-8.4
docker build -t prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-8.4-test -f test/Dockerfile-8.4 .
