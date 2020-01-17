#!/usr/bin/env sh

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
export PROJECT_NAME=skyexpo
registry=registry.hal.skygate.io

pull_image() {
    (docker pull ${registry}/$1:$2 1>/dev/null && echo "${GREEN}pulled $1:$2 image ${NC}") ||
        (echo "${RED}unable to pull $1:$2 image ${NC}" && return 1)
}

tag_image() {
    docker tag ${registry}/$1:$2 ${registry}/$1:$3 || true
}

echo "${CYAN}backing up the DB${NC}"
docker-compose exec -T skyexpo-db pg_dumpall -c -U postgres >/home/ubuntu/db_backups/$PROJECT_NAME/newest_backup.sql && echo "${GREEN}new DB dump created${NC}" || echo "${RED}failed to dump DB${NC}"
cp /home/ubuntu/db_backups/$PROJECT_NAME/newest_backup.sql /home/ubuntu/db_backups/$PROJECT_NAME/dump_$(date +%d-%m-%Y"_"%H_%M_%S).sql || echo "${RED}failed to move DB dump${NC}"

echo "${CYAN}pulling images${NC}"
pull_image skyexpo-web ${DRONE_COMMIT_SHA}
pull_image skyexpo-web-app ${DRONE_COMMIT_SHA}
pull_image skyexpo-nginx ${DRONE_COMMIT_SHA}

echo "${CYAN}waiting 10 seconds for docker to refresh available images${NC}" && sleep 10

echo "${CYAN}tagging images${NC}"
tag_image skyexpo-web ${DRONE_COMMIT_SHA} latest
tag_image skyexpo-web-app ${DRONE_COMMIT_SHA} latest
tag_image skyexpo-nginx ${DRONE_COMMIT_SHA} latest

echo "${CYAN}starting project${NC}"
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
