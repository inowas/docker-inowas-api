#!/usr/bin/env bash

cd ../app && git pull && cd ../docker
docker-compose down
docker-compose build --no-cache app
docker-compose -f docker-compose.yml up -d --no-recreate
docker-compose -f app.yml up -d --no-recreate
docker-compose ps
