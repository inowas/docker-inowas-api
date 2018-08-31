#! /bin/bash

#set -e

if ! [ -z "$(find . -mindepth 1 -maxdepth 1 -type d)" ]; then
	echo "Folder not empty"
	exit 1
fi

if ! $(git --version); then
	echo "Git not installed"
	exit 1
fi

echo "Clone API-Source code"
git clone -b master --depth 1  --recursive https://github.com/inowas/inowas_api.git api
mv ./api/users.dist.json ./api/users.json

echo "Clone APP-Source code"
git clone -b master https://github.com/inowas/inowas-dss-client.git app
echo "export default {
    baseURL: 'http://inowas.local:8001'
};" > ./app/src/config.js

echo "Clone infrastructure repository"
git clone -b master https://github.com/inowas/docker-inowas-api.git docker
cd docker
cp .env.dist .env

docker-compose up -d --no-recreate
docker-compose ps
docker-compose exec php composer install --no-interaction
docker-compose exec php bash ./build/setFolderPermissions.sh
docker-compose exec php php ./bin/console cache:clear -e prod
docker-compose exec php php ./bin/console cache:clear -e dev
docker-compose exec php php ./bin/console doctrine:database:drop --force --env=prod --if-exists
docker-compose exec php php ./bin/console doctrine:database:create --env=prod
docker-compose exec php php ./bin/console inowas:postgis:install --env=prod
docker-compose exec php php ./bin/console doctrine:schema:create --env=prod
docker-compose exec php php ./bin/console inowas:es:schema:create --env=prod
docker-compose exec php php ./bin/console inowas:projections:reset --env=prod
docker-compose exec php php ./bin/console inowas:users:load --env=prod
docker-compose exec php php ./bin/console inowas:es:migrate 1 --env=prod
docker-compose exec php php ./bin/console inowas:es:migrate 3 -e prod
