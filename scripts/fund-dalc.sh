#!/bin/bash

# Send tokens from the validator to the DALC address
# These addresses are static because the keys for the cluster are version controlled
docker exec core0 ./celestia-appd tx bank send celes1d9qrpq56t765g9umqwhvey3vn25fcmf8f6yeyx celes1dm7fp7uwrr5y68v48gg8jhd2cku7vt7f4l8w0s 1000000celes --chain-id ephemeral --keyring-backend test --keyring-dir /celestia-app -y
