#!/bin/bash
docker buildx build --push --platform=linux/arm64/v8,linux/amd64 -t prlx/k8s-openresty-php-php:build-$SHA-php-8.3 -f php/Dockerfile-8.3 .

if [ "$BRANCH" == 'master' ]; then
    docker buildx build --push --platform=linux/arm64/v8,linux/amd64 -t prlx/k8s-openresty-php-php:release-php-8.3-latest -f php/Dockerfile-8.3 .
fi
