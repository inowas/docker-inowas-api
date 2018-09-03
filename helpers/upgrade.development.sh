#! /bin/bash

set -e

SCRIPTFOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )

BASEFOLDER=$SCRIPTFOLDER/../../
API_FOLDER=$BASEFOLDER./api
APP_FOLDER=$BASEFOLDER./app
DOCKER_FOLDER=$BASEFOLDER./docker

echo "Update infrastructure folder"
echo "Check if the foldername exists"
if [ ! -d $DOCKER_FOLDER ]
then
  echo "Folder $DOCKER_FOLDER does not exist."  
  exit 1
fi

echo "Checkout infrastructure master-branch"
cd $DOCKER_FOLDER
git fetch --all
git checkout master && git merge origin/master


echo "Checkout API-Source code from master-branch"
echo "Check if the foldername exists"
if [ ! -d $API_FOLDER ]
then
  echo "Folder $API_FOLDER does not exist."  
  exit 1
fi

cd $API_FOLDER
git fetch --all 
git checkout master && git merge origin/master
git submodule update

echo "Checkout APP-Source code from dev-branch"
echo "Check if the foldername exists"
if [ ! -d $APP_FOLDER ]
then
  echo "Folder $APP_FOLDER does not exist."  
  exit 1
fi

cd $APP_FOLDER
git fetch --all 
git checkout dev && git merge origin/dev


cd $DOCKER_FOLDER
docker-compose down -v
docker-compose up -d --no-recreate
docker-compose ps
docker-compose exec php composer install --no-interaction

set +e
docker-compose exec php bash ./build/setFolderPermissions.sh

set -e
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
