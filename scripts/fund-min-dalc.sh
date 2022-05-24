#!/bin/bash

MIN_VAL_ADDR=single
DALC_ADDR=celestia1dm7fp7uwrr5y68v48gg8jhd2cku7vt7fyqwfvj
# Send tokens from the validator to the DALC address
# These addresses are static because the keys for the cluster are version controlled
docker exec core0 ./celestia-appd tx bank send $MIN_VAL_ADDR $DALC_ADDR 1000000celestia --chain-id ephemeral --keyring-backend test --home /celestia-app -y
