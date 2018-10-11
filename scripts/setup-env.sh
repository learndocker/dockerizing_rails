#!/bin/bash
set -e

docker-compose build app
docker-compose down -v
docker-compose up -d pg
docker-compose run -e WAIT_FOR_POSTGRES=true --rm app rails db:create db:migrate
docker-compose up -d
