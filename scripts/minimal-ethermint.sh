#!/bin/bash

# If we have containers currently up kill them
CONTAINERS=$(docker ps -a -q --filter "name=bridge0" --filter "name=ethermint0" --filter "name=core0")
if [ ! -z "$CONTAINERS" ]
then
    echo "Killing currently running ethermint cluster containers"
    docker kill $CONTAINERS &> /dev/null
    docker rm $CONTAINERS &> /dev/null
fi

# Make sure ethermint genesis files exist if not create them
GIT_TOP=$(git rev-parse --show-toplevel)
CONFIG_DIR=$GIT_TOP/.ethermintd
if [ ! -d $CONFIG_DIR ]
then
    source $GIT_TOP/scripts/ethermint-genesis.sh
fi


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
