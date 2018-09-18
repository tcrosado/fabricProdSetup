#!/bin/bash

# Exit on first error, print all commands.
set -e

FABRIC_START_TIMEOUT=15

#Detect architecture
ARCH=`uname -m`

# Grab the current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DOCKER_FILE="${DIR}"/composer/docker-compose-node4.yml


ARCH=$ARCH docker-compose -f "${DOCKER_FILE}" down
ARCH=$ARCH docker-compose -f "${DOCKER_FILE}" up -d

docker exec -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp" peer4.org1.example.com peer channel join -b composerchannel.block
