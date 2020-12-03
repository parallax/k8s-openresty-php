#!/bin/bash
# Used to build and deploy to minikube for local dev

BUILDNUMBER=$bamboo_buildNumber

# PHP
docker build --build-arg PHP_VERSION=8 --build-arg ATATUS_VERSION=1.10.2 -t prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-8.0 -f php/Dockerfile-8.0 .