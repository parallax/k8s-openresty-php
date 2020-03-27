#!/bin/bash
# Used to build and deploy to minikube for local dev

BUILDNUMBER=$bamboo_buildNumber

# PHP
docker build --build-arg PHP_VERSION=7.4 --build-arg ATATUS_VERSION=1.9.0 -t prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-7.4 -f php/Dockerfile-7.4 .