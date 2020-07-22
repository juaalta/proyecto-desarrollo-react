#!/bin/bash

####################
###   Binaries   ###
####################
DOCKER_COMPOSE=$(which docker-compose)
DOCKER=$(which docker)
####################

PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
APP_NAME=$(./scripts/app_name.sh)

echo "[$(date +"%Y-%m-%d %T")] Showing logs containers..."

# while read line; do export "$line";
# done < <(cat ${PROJECT_PATH}/.env | grep -v "#" | grep -v "^$")
export USER_ID=${UID}
export GROUP_ID=${UID}

# ${DOCKER_COMPOSE} \
#     -f ${PROJECT_PATH}/docker-compose.yml \
#     logs -f --tail 40    

docker run \
    -it \
    --rm \
    -v ${PROJECT_PATH}:/app \
    -v /app/node_modules \
    -p 3001:3000 \
    -e CHOKIDAR_USEPOLLING=true \
    ${APP_NAME}:dev \
    npm $1

