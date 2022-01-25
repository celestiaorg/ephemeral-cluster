#!/bin/bash

# Stop and remove core nodes
docker-compose -f docker/core-docker-compose.yml stop
docker-compose -f docker/core-docker-compose.yml rm -f

# Stop and remove bridge nodes
docker-compose -f docker/bridge-docker-compose.yml stop
docker-compose -f docker/bridge-docker-compose.yml rm -f

# Stop and remove light nodes
docker-compose -f docker/light-docker-compose.yml stop
docker-compose -f docker/light-docker-compose.yml rm -f

# Stop and remove  the DALC node
docker-compose -f docker/dalc-docker-compose.yml stop
docker-compose -f docker/dalc-docker-compose.yml rm -f