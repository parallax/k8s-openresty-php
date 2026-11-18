#!/bin/bash
set -euo pipefail

# Derive the OpenResty version from the Dockerfile base image,
# e.g. "FROM openresty/openresty:1.31.9.1-alpine" -> "1.31.9.1"
OPENRESTY_VERSION=$(grep -m1 '^FROM openresty/openresty:' openresty/Dockerfile | sed -E 's/^FROM openresty\/openresty:([0-9.]+).*/\1/' || true)

if [ -z "$OPENRESTY_VERSION" ]; then
    echo "Could not determine OpenResty version from openresty/Dockerfile" >&2
    exit 1
fi

echo "Building OpenResty $OPENRESTY_VERSION"

docker buildx build --push --platform=linux/arm64/v8,linux/amd64 -t prlx/k8s-openresty-php-openresty:build-$SHA -f openresty/Dockerfile .

if [ "$BRANCH" == 'master' ]; then
    docker buildx build --push --platform=linux/arm64/v8,linux/amd64 \
        -t prlx/k8s-openresty-php-openresty:release-$OPENRESTY_VERSION \
        -t prlx/k8s-openresty-php-openresty:release-latest \
        -f openresty/Dockerfile .
fi
