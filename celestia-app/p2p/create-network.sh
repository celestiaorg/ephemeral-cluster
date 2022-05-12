#!/bin/bash

# Script to generate a set of 4 gentxs, node_keys, priv_validator_keys, and application keys as well as a golden genesis file.

chain_id=ephemeral

# Create the orchestrator node
mkdir orchestrator
celestia-appd --home orchestrator init orchestrator --chain-id $chain_id

# Create 4 nodes with keys
nodes=( core0 core1 core2 core3 )
for name in "${nodes[@]}"
do
    : 
    mkdir $name
    acc_addr=$(./create_key.sh $name | tail -n 1)
    echo $acc_addr > $name/account-address-$name.txt
    celestia-appd --home orchestrator add-genesis-account $acc_addr 800000000000celes
done

./fix_genesis.sh orchestrator/config/genesis.json celes

mkdir orchestrator/config/gentx

for name in "${nodes[@]}"
do
    : 
    cp orchestrator/config/genesis.json $name/config/genesis.json 
    celestia-appd --home $name gentx $name 5000000000celes --keyring-backend=test --chain-id $chain_id
    cp $name/config/gentx/* orchestrator/config/gentx/
done

./celestia-appd --home orchestrator collect-gentxs

rm orchestrator/config/node_key.json
rm orchestrator/config/priv_validator_key.json
mv orchestrator/data/priv_validator_state.json . 
mv orchestrator/config/* .
rm -rf orchestrator

# Cleanup
for name in "${nodes[@]}"
do
    : 
    rm -rf $name/data
    rm $name/config/app.toml
    rm $name/config/client.toml 
    rm $name/config/config.toml
    rm $name/config/genesis.json
done