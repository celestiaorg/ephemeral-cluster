# Creates genesis in ~/.ethermintd
ethermintd init $MONIKER --chain-id=$CHAINID
ethermintd keys add mykey --keyring-backend test
ethermintd add-genesis-account mykey 100000000000000000000000000aphoton --keyring-backend test
ethermintd gentx $KEY 1000000000000000000000aphoton --keyring-backend test --chain-id $CHAINID

# Copy to ethermint directory
cp -rf $HOME/.ethermintd/ ./ethermint/

#TODO rollmint specific pieces
