#!/bin/bash

docker exec evmos0 bash -c 'evmosd keys add user1 --keyring-backend test; \
val_addr=$(evmosd keys show mykey -a --keyring-backend test); \
echo $val_addr; \
user1_addr=$(evmosd keys show user1 -a --keyring-backend test); \
echo $user1_addr; \
evmosd tx bank send $val_addr $user1_addr 1000000000000000000aevmos --chain-id=opti_9000-1 --keyring-backend=test -y; \