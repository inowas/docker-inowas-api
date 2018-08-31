#! /bin/bash

docker-compose up -d --no-recreate
docker-compose ps
docker-compose exec php php ./bin/console cache:clear -e prod
docker-compose exec php php ./bin/console cache:clear -e dev
docker-compose exec php bash ./build/build.on.docker.sh
docker-compose exec php php ./bin/console inowas:es:migrate 3
