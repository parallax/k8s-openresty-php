#!/bin/bash
# Used to build and deploy to minikube for local dev

# Openresty
TIMESTAMP=`date "+%d-%m-%y-%H-%M-%S"`
docker build -t lawrencedudley/k8s-openresty-php-openresty:$TIMESTAMP -f openresty/Dockerfile .
docker push lawrencedudley/k8s-openresty-php-openresty:$TIMESTAMP

# PHP
docker build --build-arg PHP_VERSION=7.3 --build-arg ATATUS_VERSION=1.8.0 -t lawrencedudley/k8s-openresty-php-php:$TIMESTAMP-7.3 -f php/Dockerfile .
docker push lawrencedudley/k8s-openresty-php-php:$TIMESTAMP-7.3
docker build --build-arg PHP_VERSION=7.4 --build-arg ATATUS_VERSION=1.8.0 -t lawrencedudley/k8s-openresty-php-php:$TIMESTAMP-7.3 -f php/Dockerfile .
docker push lawrencedudley/k8s-openresty-php-php:$TIMESTAMP-7.4

# Copy yaml-template
rm -f yaml-deploy/*
cp yaml-templates/* yaml-deploy/

# Values
sed -i '' -e "s#{{ OPENRESTYIMAGEHERE }}#lawrencedudley/k8s-openresty-php-openresty:$TIMESTAMP#g" yaml-deploy/deployment.yaml
sed -i '' -e "s#{{ PHPIMAGEHERE }}#lawrencedudley/k8s-openresty-php-php:$TIMESTAMP-7.3#g" yaml-deploy/deployment.yaml

# Apply to Kubernetes
kubectl apply -f yaml-deploy/deployment.yaml
kubectl apply -f yaml-deploy/service.yaml