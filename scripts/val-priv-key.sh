#!/bin/bash

# Print the validator's private key for testing
docker exec ethermint0 bash -c 'ethermintd keys unsafe-export-eth-key mykey --home /ethermint --keyring-backend test'
