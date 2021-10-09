#!/bin/bash

# set -o allexport; source .env; set +o allexport
export $(xargs <.env)

if ! docker network ls | grep -q ${COMPOSE_PROJECT_NAME}\_net
then
docker network create ${COMPOSE_PROJECT_NAME}\_net
fi

docker-compose build

if ! docker volume ls | grep -q ${COMPOSE_PROJECT_NAME}\_certs
then
  cp .env initialize/.env
  cd initialize
  docker-compose up
  cd ..
fi

docker-compose up -d --remove-orphans

# docker cp node-1:/usr/share/elasticsearch/config/certs/node-1 .
# docker cp node-1:/usr/share/elasticsearch/config/certs/ca/ca.crt ./node-1