#!/bin/bash

# Start the DALC node
echo "Creating DALC node(s)"
docker compose -f docker/mock-dalc-docker-compose.yml up -d

# Start the regular ethermint node
echo "Creating Ethermint0 node(s)"
docker compose -f docker/ethermint-docker-compose.yml up ethermint0 -d

echo sleep 15
sleep 15

# Start the regular ethermint node
echo "Creating Ethermint1 node(s)"
docker compose -f docker/ethermint-docker-compose.yml up ethermint1 -d
