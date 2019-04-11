#! /bin/sh
# Disable swap
sudo swapoff -a

###########################################################
#docker pull localhost:5000/voltha-onu_mock
#docker run -d  --name=voltha-onu_mock -p 8080:8080 -p 5656:5656 localhost:5000/voltha-onu_mock
#if [ $? -eq 0 ]; then
#    echo OK
#else
#    docker stop voltha-onu_mock
#    docker rm voltha-onu_mock
#    docker run -d  --name=voltha-onu_mock -p 8080:8080 -p 5656:5656 localhost:5000/voltha-onu_mock
#fi

docker-compose -f /home/voltha/compose/docker-compose-min-system-test.yml up -d
docker-compose -f /home/voltha/compose/docker-compose-local-auth-test.yml up -d onos
#
#
# TODO: Need to add support for the following
#   - Compose file for ONU Mock so it works in the proper network
#   - Send netcfg.json to ONOS (Need to edit this for our config)
#   - Update the EAPOL credentials (if needed)
#   - Support kubernetes
#   - Mount netcfg and credentials as volumns?