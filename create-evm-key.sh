#!/bin/bash

# ONE_APHOTON=1000000000000000000aphoton
# CHAINID="opti_9000-1"

# Create a new key, fund it from the genesis account, and export its private key to be used with wallets and CLIs
docker exec evmos0 bash -c 'evmosd keys add external --keyring-backend test; \
val_addr=$(evmosd keys show mykey -a --keyring-backend test); \
ext_addr=$(evmosd keys show external -a --keyring-backend test); \
evmosd tx bank send $val_addr $ext_addr 1000000000000000000aphoton --chain-id=opti_9000-1 --keyring-backend=test -y; \
echo "external key"; \
evmosd keys unsafe-export-eth-key external --keyring-backend test;
echo "initial key"; \
evmosd keys unsafe-export-eth-key mykey --keyring-backend test'
