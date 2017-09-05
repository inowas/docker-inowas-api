#!/usr/bin/env bash

GREEN=`tput setaf 2`
RESET=`tput sgr0`

if [ ! -f .env ]; then
    echo "${GREEN}Please copy the tile .env.dist to .env and configure for your needs!${RESET}"
    return 1;
fi

COMPOSE_FILES=docker-compose.yml
CAN_START=`env | grep COMPOSE_FILE | tr -d '\r\n'`

if [[ "${CAN_START}" != "" && "${CAN_START}" != "COMPOSE_FILE=${COMPOSE_FILES}" ]]; then
    echo "${GREEN}This terminal is already used for another microservice!${RESET}"
    echo $COMPOSE_FILE
    echo "${GREEN}You have to use an extra terminal to avoid environment variables collision.${RESET}"
    return 1;
fi

# Docker Compose
export COMPOSE_PROJECT_NAME=inowas-dev
export COMPOSE_FILE=${COMPOSE_FILES}

echo "Using $COMPOSE_FILE"

docker-compose up -d --no-recreate
docker-compose ps
