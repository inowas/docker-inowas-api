#! /bin/bash

set -e

SCRIPT_FOLDER=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )

# Load env-variables
set -a
[ -f ${SCRIPT_FOLDER}/../.env ] && . ${SCRIPT_FOLDER}/../.env
set +a

BASE_FOLDER=${SCRIPT_FOLDER}/../../
API_FOLDER=${BASE_FOLDER}./api
APP_FOLDER=${BASE_FOLDER}./app
DOCKER_FOLDER=${BASE_FOLDER}./docker

echo "Update infrastructure folder"
echo "Check if the foldername exists"
if [ ! -d ${DOCKER_FOLDER} ]
then
  echo "Folder $DOCKER_FOLDER does not exist."
  exit 1
fi

echo "Checkout infrastructure master-branch"
cd ${DOCKER_FOLDER}
git checkout origin/master


echo "Checkout API-Source code from master-branch"
echo "Check if the foldername exists"
if [ ! -d ${API_FOLDER} ]
then
  echo "Folder $API_FOLDER does not exist."
  exit 1
fi

cd ${API_FOLDER}
git checkout origin/master
git submodule update

echo "Checkout APP-Source code from dev-branch"
echo "Check if the foldername exists"
if [ ! -d ${APP_FOLDER} ]
then
  echo "Folder $APP_FOLDER does not exist."
  exit 1
fi

cd ${APP_FOLDER}
git checkout master && git pull origin/master

cd ${DOCKER_FOLDER}
docker-compose -f app.yml down -v
docker-compose -f docker-compose.yml down -v
docker-compose -f app.yml up -d --no-recreate --build
docker-compose -f docker-compose.yml up -d --no-recreate
docker-compose ps

docker-compose exec php composer install --no-interaction
set +e
docker-compose exec php bash ./build/setFolderPermissions.sh
docker-compose exec php bash ./build/setDataFolderPermissions.sh ${API_DATA_FOLDER}
set -e
