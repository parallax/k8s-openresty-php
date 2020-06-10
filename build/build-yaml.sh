#!/bin/bash
# Used to build and deploy to minikube for local dev

BUILDNUMBER=$bamboo_buildNumber

# Copy yaml-template
rm -f yaml-deploy/*
cp yaml-templates/* yaml-deploy/

# Values
sed -i -e "s#{{ OPENRESTYIMAGEHERE }}#prlx/k8s-openresty-php-openresty:build-$BUILDNUMBER#g" yaml-deploy/deployment-5.6.yaml
sed -i -e "s#{{ OPENRESTYIMAGEHERE }}#prlx/k8s-openresty-php-openresty:build-$BUILDNUMBER#g" yaml-deploy/deployment-7.1.yaml
sed -i -e "s#{{ OPENRESTYIMAGEHERE }}#prlx/k8s-openresty-php-openresty:build-$BUILDNUMBER#g" yaml-deploy/deployment-7.2.yaml
sed -i -e "s#{{ OPENRESTYIMAGEHERE }}#prlx/k8s-openresty-php-openresty:build-$BUILDNUMBER#g" yaml-deploy/deployment-7.3.yaml
sed -i -e "s#{{ OPENRESTYIMAGEHERE }}#prlx/k8s-openresty-php-openresty:build-$BUILDNUMBER#g" yaml-deploy/deployment-7.4.yaml
sed -i -e "s#{{ PHP5.6IMAGEHERE }}#prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-5.6-test#g" yaml-deploy/deployment-5.6.yaml
sed -i -e "s#{{ PHP7.1IMAGEHERE }}#prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-7.1-test#g" yaml-deploy/deployment-7.1.yaml
sed -i -e "s#{{ PHP7.2IMAGEHERE }}#prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-7.2-test#g" yaml-deploy/deployment-7.2.yaml
sed -i -e "s#{{ PHP7.3IMAGEHERE }}#prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-7.3-test#g" yaml-deploy/deployment-7.3.yaml
sed -i -e "s#{{ PHP7.4IMAGEHERE }}#prlx/k8s-openresty-php-php:build-$BUILDNUMBER-php-7.4-test#g" yaml-deploy/deployment-7.4.yaml