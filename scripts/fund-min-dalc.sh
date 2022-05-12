#!/bin/bash

MIN_VAL_ADDR=celes1z4t2fnem459xcfj5kknnd5yy8rp4frhdnnkel9
DALC_ADDR=celes1dm7fp7uwrr5y68v48gg8jhd2cku7vt7f4l8w0s
# Send tokens from the validator to the DALC address
# These addresses are static because the keys for the cluster are version controlled
docker exec core0 ./celestia-appd tx bank send $MIN_VAL_ADDR $DALC_ADDR 1000000celes --chain-id ephemeral --keyring-backend test --keyring-dir /celestia-app -y
