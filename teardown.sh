#!/bin/bash
export $(xargs <.env)

docker-compose down --remove-orphans
docker volume rm ${COMPOSE_PROJECT_NAME}\_certs
