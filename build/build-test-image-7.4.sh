#!/bin/bash
BUILDNUMBER=$bamboo_buildNumber

sed -i -e "s#{{ BUILDNUMBER }}#$BUILDNUMBER#g" test/Dockerfile-7.4
docker build -t prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-7.4-test -f test/Dockerfile-7.4 .