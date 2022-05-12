#!/bin/bash

# Ensure key permissions are setup
chmod 0600 celestia-node/bridge/*/nodekey*
chmod 0600 celestia-node/light/*/nodekey*
chmod 0600 dalc/celestia-light/keys/*

# Start core0 core node
echo "Creating core node(s)"
docker compose -f docker/minimal/core-docker-compose.yml up -d 

echo "Waiting 30s for core nodes to produce a block"
sleep 30s

# Start full0 bridge node
echo "Creating bridge node(s)"
docker compose -f docker/minimal/bridge-docker-compose.yml up bridge0 -d

echo "Waiting 10s for bridge nodes to sync a block"
sleep 10s

# Start light0 light node
echo "Creating light node(s)"
docker compose -f docker/minimal/light-docker-compose.yml up light0 -d

echo "Waiting 10s for light nodes to perform DA sampling"
sleep 10s

# Start the DALC node
echo "Creating DALC node(s)"
docker compose -f docker/old/old-dalc-docker-compose.yml up -d

echo "Waiting 5s for dalc to start"
sleep 5s

# Fund the DALC node
scripts/fund-min-dalc.sh

echo "Sleeping 10s to wait for DALC funding tx to go through"
sleep 10s

# Start the regular ethermint node
echo "Creating Ethermint node(s)"
docker compose -f docker/old/old-ethermint-docker-compose.yml up -d
