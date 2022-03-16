#!/bin/bash

# Ensure key permissions are setup
chmod 0600 celestia-node/full/*/nodekey*
chmod 0600 celestia-node/light/*/nodekey*
chmod 0600 dalc/celestia-light/keys/*

# Start core0 core node
echo "Creating core node(s)"
docker-compose -f docker/core-docker-compose.yml up -d 

echo "Waiting 30s for core nodes to produce a block"
sleep 30s

# Start full0 bridge node
echo "Creating bridge node(s)"
docker-compose -f docker/debug-bridge.yml up -d

echo "Waiting 10s for bridge nodes to sync a block"
sleep 10s

# Start light0 light node
echo "Creating light node(s)"
docker-compose -f docker/debug-light.yml up light0 -d

echo "Waiting 10s for light nodes to perform DA sampling"
sleep 10s

# Start the DALC node
echo "Creating DALC node(s)"
docker-compose -f docker/dalc-docker-compose.yml up -d

# Fund the DALC node
./fund-dalc.sh

echo "Sleeping 10s to wait for DALC funding tx to go through"
sleep 10s

# Extra sleep for CI
sleep 30s

# Start the regular cevmos node
echo "Creating Cevmos node(s)"
docker-compose -f docker/evmos-docker-compose.yml up -d

# Start the debug cevmos node
# docker-compose -f docker/debug-evmos.yml up -d