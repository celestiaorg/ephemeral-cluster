#!/bin/bash

# Print the validator's private key for testing
docker exec evmos0 bash -c 'evmosd keys unsafe-export-eth-key mykey --keyring-backend test'