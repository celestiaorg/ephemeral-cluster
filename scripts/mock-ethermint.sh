#!/bin/bash

# Start the DALC node
echo "Creating DALC node(s)"
docker compose -f docker/mock-dalc-docker-compose.yml up -d

# Start the regular ethermint node
echo "Creating Ethermint0 node(s)"
docker compose -f docker/ethermint-mock-docker-compose.yml up ethermint0 -d

echo sleep 5
sleep 5

# Start the regular ethermint node
echo "Creating Ethermint1 node(s)"
docker compose -f docker/ethermint-mock-docker-compose.yml up ethermint1 -d
