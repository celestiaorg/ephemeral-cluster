#!/bin/bash

# Ensure key permissions are setup
chmod 0600 celestia-node/bridge/*/nodekey*
chmod 0600 celestia-node/light/*/nodekey*
chmod 0600 dalc/celestia-light/keys/*

# Start core nodes
docker compose -f docker/p2p/core-docker-compose.yml up -d 

echo "Waiting 40s for core nodes to produce a block"
sleep 40s

# Start bridge nodes
docker compose -f docker/p2p/bridge-docker-compose.yml up -d

echo "Waiting 30s for bridge nodes to sync a block"
sleep 30s

# Start light nodes
docker compose -f docker/p2p/light-docker-compose.yml up -d
