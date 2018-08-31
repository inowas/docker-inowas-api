#! /bin/bash

docker-compose up -d --no-recreate
docker-compose ps
sleep 5
docker-compose exec php bash ./build/build.on.docker.sh
docker-compose exec php php ./bin/console inowas:es:migrate 3
