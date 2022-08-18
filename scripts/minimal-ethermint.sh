#!/bin/bash

# Ensure key permissions are setup
chmod 0600 celestia-node/bridge/*/nodekey*
chmod 0600 celestia-node/light/*/nodekey*

# Start core0 core node
echo "Creating core node(s)"
docker compose -f docker/minimal/core-docker-compose.yml up -d

echo "Waiting 5s for core nodes to produce a block"
sleep 5s

# Start the DALC node
echo "Creating DALC node(s)"
docker compose -f docker/minimal/dalc-docker-compose.yml up -d

echo "Waiting 5s for dalc to start"
sleep 5s

# Start the regular ethermint node
echo "Creating Ethermint node(s)"
docker compose -f docker/ethermint/ethermint-docker-compose.yml up -d
