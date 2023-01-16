#!/bin/bash

# Ensure key permissions are setup
chmod 0600 celestia-node/bridge/*/nodekey*
chmod 0600 celestia-node/light/*/nodekey*
chmod 0600 dalc/celestia-light/keys/*

# If we have containers currently up kill them
CONTAINERS=$(docker ps -a -q --filter "name=bridge0" --filter "name=light0" --filter "name=core0")
if [ ! -z "$CONTAINERS" ]
then
    echo "Killing currently running ethermint cluster containers"
    docker kill $CONTAINERS &> /dev/null
    docker rm $CONTAINERS &> /dev/null
fi

# Start 1 core node
echo "Creating core node(s)"
docker compose -f docker/minimal/core-docker-compose.yml up -d 

echo "Waiting 5s for core nodes to produce a block"
sleep 5

# Start bridge0 bridge node
echo "Creating bridge node(s)"
docker compose -f docker/minimal/bridge-docker-compose.yml up -d

echo "Waiting 10s for bridge nodes to sync a block"
sleep 10

# Start light0 light node
echo "Creating light node(s)"
docker compose -f docker/minimal/light-docker-compose.yml up -d
