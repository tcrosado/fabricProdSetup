#!/bin/bash

HOST0=""
HOST1=""
HOST2=""
HOST3=""
HOST4=""

PEER0=$HOST0" peer0.org1.example.com"
PEER1=$HOST1" peer1.org1.example.com"
PEER2=$HOST2" peer2.org1.example.com"
PEER3=$HOST3" peer3.org1.example.com"
PEER4=$HOST4" peer4.org1.example.com"

ORDERER0=$HOST1" orderer0.example.com"
ORDERER1=$HOST2" orderer1.example.com"
ORDERER2=$HOST3" orderer2.example.com"

ZKEEP0=$HOST1" zookeeper0.example.com"
ZKEEP1=$HOST3" zookeeper1.example.com"
ZKEEP2=$HOST4" zookeeper2.example.com"

KAFKA0=$HOST0" kafka0.example.com"
KAFKA1=$HOST0" kafka1.example.com"
KAFKA2=$HOST0" kafka2.example.com"
KAFKA3=$HOST0" kafka3.example.com"

sed -i -e "s/{HOST-0}/$HOST0/g" ../createPeerAdminCard.sh
sed -i -e "s/{HOST-1}/$HOST1/g" ../createPeerAdminCard.sh
sed -i -e "s/{HOST-2}/$HOST2/g" ../createPeerAdminCard.sh
sed -i -e "s/{HOST-3}/$HOST3/g" ../createPeerAdminCard.sh
sed -i -e "s/{HOST-4}/$HOST4/g" ../createPeerAdminCard.sh

cryptogen generate --config=./crypto-config.yaml
export FABRIC_CFG_PATH=$PWD
configtxgen -profile ComposerOrdererGenesis -outputBlock ./composer-genesis.block
configtxgen -profile ComposerChannel -outputCreateChannelTx ./composer-channel.tx -channelID composerchannel

echo $PEER0 >> /etc/hosts
echo $PEER1 >> /etc/hosts
echo $PEER2 >> /etc/hosts
echo $PEER3 >> /etc/hosts
echo $ORDERER0 >> /etc/hosts
echo $ORDERER1 >> /etc/hosts
echo $ORDERER2 >> /etc/hosts
echo $ZKEEP0 >> /etc/hosts
echo $ZKEEP1 >> /etc/hosts
echo $ZKEEP2 >> /etc/hosts
echo $KAFKA0 >> /etc/hosts
echo $KAFKA1 >> /etc/hosts
echo $KAFKA2 >> /etc/hosts
echo $KAFKA3 >> /etc/hosts

tar cf - ./composer-genesis.block | nc $HOST0 1010
tar cf - ./composer-channel.tx | nc $HOST0 1010
tar cf - crypto-config/ | nc $HOST0 1010

tar cf - ./composer-genesis.block | nc $HOST1 1010
tar cf - ./composer-channel.tx | nc $HOST1 1010
tar cf - crypto-config/ | nc $HOST1 1010

tar cf - ./composer-genesis.block | nc $HOST2 1010
tar cf - ./composer-channel.tx | nc $HOST2 1010
tar cf - crypto-config/ | nc $HOST2 1010

tar cf - ./composer-genesis.block | nc $HOST3 1010
tar cf - ./composer-channel.tx | nc $HOST3 1010
tar cf - crypto-config/ | nc $HOST3 1010
