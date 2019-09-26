#!/bin/bash
# Used to build and deploy to minikube for local dev

BUILDNUMBER=$bamboo_buildNumber

# Openresty
docker build -t prlx/k8s-openresty-php-openresty:build-$BUILDNUMBER -f ../openresty/Dockerfile ../