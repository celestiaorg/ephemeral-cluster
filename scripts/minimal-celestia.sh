#!/bin/bash

# Ensure key permissions are setup
chmod 0600 celestia-node/bridge/*/nodekey*
chmod 0600 celestia-node/light/*/nodekey*
chmod 0600 dalc/celestia-light/keys/*

# Start 1 core node
echo "Creating core node(s)"
docker compose -f docker/minimal/core-docker-compose.yml up -d 

echo "Waiting 30s for core nodes to produce a block"
sleep 30s

# Start bridge0 bridge node
echo "Creating bridge node(s)"
docker compose -f docker/minimal/bridge-docker-compose.yml up -d

echo "Waiting 10s for bridge nodes to sync a block"
sleep 10s

# Start light0 light node
echo "Creating light node(s)"
docker compose -f docker/minimal/light-docker-compose.yml up -d
