#!/bin/bash
# Used to build and deploy to minikube for local dev

BUILDNUMBER=$bamboo_buildNumber

# Copy yaml-template
rm -f ../yaml-deploy/*
cp ../yaml-templates/* ../yaml-deploy/

# Values
sed -i '' -e "s#{{ OPENRESTYIMAGEHERE }}#prlx/k8s-openresty-php-openresty:build-$BUILDNUMBER#g" ../yaml-deploy/deployment.yaml
sed -i '' -e "s#{{ PHP7.1IMAGEHERE }}#prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-7.1#g" ../yaml-deploy/deployment-7.1.yaml
sed -i '' -e "s#{{ PHP7.2IMAGEHERE }}#prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-7.2#g" ../yaml-deploy/deployment-7.2.yaml
sed -i '' -e "s#{{ PHP7.3IMAGEHERE }}#prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-7.3#g" ../yaml-deploy/deployment-7.3.yaml