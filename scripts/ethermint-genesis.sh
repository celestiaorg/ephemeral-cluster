MONIKER=localtestnet
CHAINID=roll_9000-1
KEY=mykey
KEYRING=test

rm -rf $HOME/.ethermintd

# Creates genesis in ~/.ethermintd
ethermintd init $MONIKER --chain-id=$CHAINID
ethermintd keys add mykey --keyring-backend $KEYRING
ethermintd add-genesis-account mykey 100000000000000000000000000aphoton --keyring-backend $KEYRING
ethermintd gentx $KEY 1000000000000000000000aphoton --keyring-backend $KEYRING --chain-id $CHAINID

# Copy to ethermint directory
cp -rf $HOME/.ethermintd/ ./ethermint/

# Speed up block creation
sed -i '' 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' ./ethermint/config/config.toml
sed -i '' 's/timeout_propose = "3s"/timeout_propose = "30s"/g' ./ethermint/config/config.toml
sed -i '' 's/timeout_propose_delta = "100ms"/timeout_propose_delta = "5s"/g' ./ethermint/config/config.toml
sed -i '' 's/timeout_prevote = "100ms"/timeout_prevote = "10s"/g' ./ethermint/config/config.toml
sed -i '' 's/timeout_prevote_delta = "100ms"/timeout_prevote_delta = "5s"/g' ./ethermint/config/config.toml
sed -i '' 's/timeout_precommit = "100ms"/timeout_precommit = "10s"/g' ./ethermint/config/config.toml
sed -i '' 's/timeout_precommit_delta = "100ms"/timeout_precommit_delta = "5s"/g' ./ethermint/config/config.toml
sed -i '' 's/timeout_commit = "2s"/timeout_commit = "150s"/g' ./ethermint/config/config.toml
sed -i '' 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' ./ethermint/config/config.toml