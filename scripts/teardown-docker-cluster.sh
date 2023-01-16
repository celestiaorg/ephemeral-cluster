#!/bin/bash


# Only deleting docker containers which our scripts might actually build
CONTAINERS=$(docker ps -a -q --filter "name=bridge0" --filter "name=light0" --filter "name=core0" --filter "name=ethermint0")
if [ ! -z "$CONTAINERS" ]
then
    echo "Killing currently running ephemeral cluster containers"
    docker kill $CONTAINERS &> /dev/null
    docker rm $CONTAINERS &> /dev/null
fi
