#!/bin/bash
# Used to build and deploy to minikube for local dev

BUILDNUMBER=$bamboo_buildNumber

# PHP
docker build --build-arg PHP_VERSION=5.6 --build-arg ATATUS_VERSION=1.8.0 -t prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-5.6 -f php/Dockerfile-5.6 .
