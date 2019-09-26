#!/bin/bash
# Used to build and deploy to minikube for local dev

$BUILDNUMBER=${bamboo.buildNumber}

# PHP
docker build --build-arg PHP_VERSION=7.2 --build-arg ATATUS_VERSION=1.8.0 -t prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-7.2 -f ../php/Dockerfile ../