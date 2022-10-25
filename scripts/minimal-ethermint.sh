#!/bin/bash

# Start core0 core node
echo "Creating core node"
docker compose -f docker/minimal/core-docker-compose.yml up -d

echo "Waiting 5s for core node to produce a block"
sleep 5

# Start the Bridge node
echo "Creating Bride node"
docker compose -f docker/minimal/bridge-docker-compose.yml up -d

echo "Waiting 5s for dalc to start"
sleep 5

# Start the regular ethermint node
echo "Creating Ethermint node"
docker compose -f docker/ethermint/ethermint-docker-compose.yml up -d
