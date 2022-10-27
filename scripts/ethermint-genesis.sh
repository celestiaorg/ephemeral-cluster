MONIKER=localtestnet
CHAINID=roll_9000-1
KEY=mykey
KEYRING=test

DIRECTORY=/tmp/.ethermintd

# Creates genesis in ~/.ethermintd
ethermintd init $MONIKER --chain-id=$CHAINID --home $DIRECTORY
ethermintd keys add mykey --keyring-backend $KEYRING --home $DIRECTORY
ethermintd add-genesis-account mykey 100000000000000000000000000aphoton --keyring-backend $KEYRING --home $DIRECTORY

# Change parameter token denominations to aphoton
cat $DIRECTORY/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="aphoton"' > $DIRECTORY/config/tmp_genesis.json && mv $DIRECTORY/config/tmp_genesis.json $DIRECTORY/config/genesis.json
cat $DIRECTORY/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="aphoton"' > $DIRECTORY/config/tmp_genesis.json && mv $DIRECTORY/config/tmp_genesis.json $DIRECTORY/config/genesis.json
cat $DIRECTORY/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="aphoton"' > $DIRECTORY/config/tmp_genesis.json && mv $DIRECTORY/config/tmp_genesis.json $DIRECTORY/config/genesis.json
cat $DIRECTORY/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="aphoton"' > $DIRECTORY/config/tmp_genesis.json && mv $DIRECTORY/config/tmp_genesis.json $DIRECTORY/config/genesis.json

ethermintd gentx $KEY 1000000000000000000000aphoton --keyring-backend $KEYRING --chain-id $CHAINID --home $DIRECTORY
ethermintd collect-gentxs --home $DIRECTORY 
ethermintd validate-genesis --home $DIRECTORY 


CONFIG_LOCATION=$DIRECTORY/config/config.toml
# Speed up block creation
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $CONFIG_LOCATION
    sed -i '' 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $CONFIG_LOCATION
    sed -i '' 's/timeout_propose_delta = "100ms"/timeout_propose_delta = "5s"/g' $CONFIG_LOCATION
    sed -i '' 's/timeout_prevote = "100ms"/timeout_prevote = "10s"/g' $CONFIG_LOCATION
    sed -i '' 's/timeout_prevote_delta = "100ms"/timeout_prevote_delta = "5s"/g' $CONFIG_LOCATION
    sed -i '' 's/timeout_precommit = "100ms"/timeout_precommit = "10s"/g' $CONFIG_LOCATION
    sed -i '' 's/timeout_precommit_delta = "100ms"/timeout_precommit_delta = "5s"/g' $CONFIG_LOCATION
    sed -i '' 's/timeout_commit = "2s"/timeout_commit = "150s"/g' $CONFIG_LOCATION
    sed -i '' 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $CONFIG_LOCATION
else
    sed -i 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $CONFIG_LOCATION
    sed -i 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $CONFIG_LOCATION
    sed -i 's/timeout_propose_delta = "100ms"/timeout_propose_delta = "5s"/g' $CONFIG_LOCATION
    sed -i 's/timeout_prevote = "100ms"/timeout_prevote = "10s"/g' $CONFIG_LOCATION
    sed -i 's/timeout_prevote_delta = "100ms"/timeout_prevote_delta = "5s"/g' $CONFIG_LOCATION
    sed -i 's/timeout_precommit = "100ms"/timeout_precommit = "10s"/g' $CONFIG_LOCATION
    sed -i 's/timeout_precommit_delta = "100ms"/timeout_precommit_delta = "5s"/g' $CONFIG_LOCATION
    sed -i 's/timeout_commit = "2s"/timeout_commit = "150s"/g' $CONFIG_LOCATION
    sed -i 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $CONFIG_LOCATION
fi

cat << EOF >> $CONFIG_LOCATION

[rollmint]
aggregator = "true"
block_time = "5s"
namespace_id = "0001020304050607"
da_layer = "celestia"
da_config = '{"base_url":"http://192.167.3.0:26658","timeout":60000000000,"gas_limit":6000000,"namespace_id":[0,1,2,3,4,5,6,7]}'

[json-rpc]
enable = "true"
api = "eth,txpool,personal,net,web3,miner"
address = "0.0.0.0:8545"
EOF

# Completely replace local ethermint, and cleanup
GIT_TOP=$(git rev-parse --show-toplevel)
CONFIG_DIR=$GIT_TOP/.ethermintd
rm -rf $CONFIG_DIR
cp -rf $DIRECTORY $CONFIG_DIR/
rm -rf $DIRECTORY