#!/usr/bin/env bash
# Script for Wazuh v4.14.2 Docker installation
# Run on ubuntu/debian-based distro

WAZUH_DIR="./single-node"

echo "===SETTING UP OPTION FOR DOCKER==="
sysctl -w vm.max_map_count=262144
echo

echo "===INSTALLING PACKAGES==="
apt install docker-compose -y
echo

read -p "Enter username for Wazuh: " USERNAME
read -s -p "Enter password for Wazuh: " PASSWORD
echo

echo
sed -i.bak \
  -e "s/^ *- *INDEXER_USERNAME=.*/      - INDEXER_USERNAME=${USERNAME}/" \
  -e "s/^ *- *INDEXER_PASSWORD=.*/      - INDEXER_PASSWORD=${PASSWORD}/" \
  "${WAZUH_DIR}/docker-compose.yml"


echo '===CERTIFICATES GENERATION==='
docker-compose -f $WAZUH_DIR/generate-indexer-certs.yml run --rm generator
echo

echo '===STARTING WAZUH CONTAINERS==='
docker-compose -f $WAZUH_DIR/docker-compose.yml up -d
