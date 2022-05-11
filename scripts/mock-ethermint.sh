#!/bin/bash

# Start the DALC node
echo "Creating DALC node(s)"
docker compose -f docker/mock/mock-dalc-docker-compose.yml up -d

# Start the regular ethermint node
echo "Creating Ethermint0 node(s)"
docker compose -f docker/mock/ethermint-mock-docker-compose.yml up -d
