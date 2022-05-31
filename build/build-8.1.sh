#!/bin/bash
# Used to build and deploy to minikube for local dev

BUILDNUMBER=$bamboo_buildNumber

# PHP
docker buildx build --push --platform=linux/arm64/v8,linux/amd64 -t prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-8.1 -f php/Dockerfile-8.1 .