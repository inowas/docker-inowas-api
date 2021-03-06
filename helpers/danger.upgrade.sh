#!/usr/bin/env bash

cd ../app && git pull && git submodule update && cd ../docker
cd ../api && git pull && git submodule update && cd ../docker

# Doctrine schema update
docker-compose exec php ./bin/console doctrine:schema:update --force
docker-compose exec php ./bin/console cache:clear -e prod
docker-compose exec php ./bin/console cache:clear -e dev
docker-compose exec php ./bin/console cache:clear -e test

# docker-compose stop app
docker-compose down
docker-compose build --no-cache app
docker-compose -f docker-compose.yml up -d --no-recreate
docker-compose -f app.yml up -d --no-recreate
docker-compose ps

# remove exited containers:
docker ps --filter status=dead --filter status=exited -aq | xargs -r docker rm -v

# remove unused images:
docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r docker rmi
