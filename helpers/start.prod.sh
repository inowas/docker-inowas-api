#!/usr/bin/env bash

docker-compose -f docker-compose.yml up -d --no-recreate
docker-compose -f app.yml up -d --no-recreate
docker-compose ps
