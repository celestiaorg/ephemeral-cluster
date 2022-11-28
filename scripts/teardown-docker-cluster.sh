#!/bin/bash
for name in core0 dalc0 light0 ethermint0; do
    docker_id=$(docker ps -q  -a --filter name=$name)
    [ -n "$docker_id" ] && (docker kill $docker_id; docker rm $docker_id)
done
