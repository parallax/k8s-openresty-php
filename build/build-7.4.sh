#!/bin/bash
docker buildx build --push --platform=linux/arm64/v8,linux/amd64 -t prlx/k8s-openresty-php-php:build-$SHA-php-7.4 -f php/Dockerfile-7.4 .

if [ "$BRANCH" == 'master' ]; then
    docker buildx build --push --platform=linux/arm64/v8,linux/amd64 -t prlx/k8s-openresty-php-php:release-php-7.4-latest -f php/Dockerfile-7.4 .
fi
