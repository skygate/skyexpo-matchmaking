#!/usr/bin/env sh

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
branch=${DRONE_SOURCE_BRANCH//\//-}-${DRONE_TARGET_BRANCH//\//-}
registry=registry.hal.skygate.io

push_image() {
    docker push ${registry}/$1:$2 1>/dev/null && echo -e "${GREEN}pushed $1:$2${NC}"
}

tag_image() {
    docker tag ${registry}/$1:$2 ${registry}/$1:$3 || true
}

echo $DOCKER_REGISTRY_PWD | docker login -u $DOCKER_REGISTRY_USR --password-stdin registry.hal.skygate.io

echo -e "${CYAN}tagging images for deployment${NC}"
tag_image skyexpo-web latest ${DRONE_COMMIT_SHA}
tag_image skyexpo-web-app latest ${DRONE_COMMIT_SHA}
tag_image skyexpo-nginx latest ${DRONE_COMMIT_SHA}

echo -e "${CYAN}pushing images for deployment${NC}"
push_image skyexpo-web ${DRONE_COMMIT_SHA}
push_image skyexpo-web-app ${DRONE_COMMIT_SHA}
push_image skyexpo-nginx ${DRONE_COMMIT_SHA}