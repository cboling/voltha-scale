#! /bin/sh
# Disable swap
echo "Disabling swap"
swapoff -a

# No updates/upgrades wanted
systemctl stop --now apt-daily{,-upgrade}.timer
systemctl disable --now apt-daily{,-upgrade}.{timer,service}

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
echo "Running docker compose"

if [ -f /home/voltha/compose/docker-compose-min-system-test.yml ]
then
    docker-compose -f /home/voltha/compose/docker-compose-min-system-test.yml up -d
fi
if [ -f /home/voltha/compose/docker-compose-system-test.yml ]
then
    docker-compose -f /home/voltha/compose/docker-compose-system-test.yml up -d
fi
if [ -f /home/voltha/compose/docker-compose-local-auth-test.yml ]
then
    docker-compose -f /home/voltha/compose/docker-compose-local-auth-test.yml up -d onos
fi

echo "Scheduling Cleanup"

# Clean up any old/stopped containers
#
(sleep 5; docker ps -aq --no-trunc -f status=exited 2>/dev/null | xargs docker rm >/dev/null 2>&1) &

echo "Done with VOLTHA start"
#
#
# TODO: Need to add support for the following
#   - Compose file for ONU Mock so it works in the proper network
#   - Send netcfg.json to ONOS (Need to edit this for our config)
#   - Update the EAPOL credentials (if needed)
#   - Support kubernetes
#   - Mount netcfg and credentials as volumns
