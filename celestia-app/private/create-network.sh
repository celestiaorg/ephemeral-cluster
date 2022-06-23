#!/bin/bash

chain_id=private
token=utia

celestia-appd config keyring-backend test
celestia-appd config chain-id $chain_id
celestia-appd keys add key-1 --keyring-backend test 
celestia-appd init moniker --chain-id $chain_id
celestia-appd add-genesis-account key-1 800000000000utia --keyring-backend test

./fix_genesis.sh ~/.celestia-app/config/genesis.json $token

celestia-appd gentx key-1 5000000000utia --keyring-backend test --chain-id $chain_id
celestia-appd collect-gentxs
celestia-appd validate-genesis