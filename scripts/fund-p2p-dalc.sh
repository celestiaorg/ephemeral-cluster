#!/bin/bash

P2P_VAL_ADDR=celes1d9qrpq56t765g9umqwhvey3vn25fcmf8f6yeyx
DALC_ADDR=celes1dm7fp7uwrr5y68v48gg8jhd2cku7vt7f4l8w0s
# Send tokens from the validator to the DALC address
# These addresses are static because the keys for the cluster are version controlled
docker exec core0 ./celestia-appd tx bank send $P2P_VAL_ADDR $DALC_ADDR 1000000celes --chain-id ephemeral --keyring-backend test --keyring-dir /celestia-app -y
