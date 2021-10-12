#!/bin/bash

# set -o allexport; source .env; set +o allexport
export $(xargs <.env)

if ! docker network ls | grep -q ${COMPOSE_PROJECT_NAME}\_net
then
docker network create ${COMPOSE_PROJECT_NAME}\_net
fi

if ! docker volume ls | grep -q ${COMPOSE_PROJECT_NAME}\_certs
then
  cp .env initialize/.env
  cd initialize
  docker-compose up
  cd ..
fi

# We need to get the CA certificate so we can add it to the Java Keystore in our web app
docker-compose up -d node-1 --remove-orphans
docker cp node-1:/usr/share/elasticsearch/config/certs/ca/ca.crt ./web_app

docker-compose build
docker-compose up -d
