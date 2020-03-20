#!/bin/bash
BUILDNUMBER=$bamboo_buildNumber

sed -i -e "s#{{ BUILDNUMBER }}#$BUILDNUMBER#g" test/Dockerfile-5.6
docker build -t prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-5.6-test -f test/Dockerfile-5.6 .