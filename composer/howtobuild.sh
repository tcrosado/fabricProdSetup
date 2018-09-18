#!/bin/bash

HOST0=""
HOST1=""
HOST2=""
HOST3=""
HOST4=""

sed -i -e "s/{HOST-0}/$HOST0/g" ../createPeerAdminCard.sh
sed -i -e "s/{HOST-1}/$HOST1/g" ../createPeerAdminCard.sh
sed -i -e "s/{HOST-2}/$HOST2/g" ../createPeerAdminCard.sh
sed -i -e "s/{HOST-3}/$HOST3/g" ../createPeerAdminCard.sh
sed -i -e "s/{HOST-4}/$HOST4/g" ../createPeerAdminCard.sh

cryptogen generate --config=./crypto-config.yaml
export FABRIC_CFG_PATH=$PWD
configtxgen -profile ComposerOrdererGenesis -outputBlock ./composer-genesis.block
configtxgen -profile ComposerChannel -outputCreateChannelTx ./composer-channel.tx -channelID composerchannel
