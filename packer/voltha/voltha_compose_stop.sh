#!/bin/sh
docker stop voltha-onu_mock
docker rm voltha-onu_mock

if [ -f /home/voltha/compose/docker-compose-min-system-test.yml ]
then
    docker-compose -f /home/voltha/compose/docker-compose-min-system-test.yml stop
fi
if [ -f /home/voltha/compose/docker-compose-system-test.yml ]
then
    docker-compose -f /home/voltha/compose/docker-compose-system-test.yml stop
fi
if [ -f /home/voltha/compose/docker-compose-local-auth-test.yml ]
then
    docker-compose -f /home/voltha/compose/docker-compose-local-auth-test.yml stop
fi


if [ -f /home/voltha/compose/docker-compose-min-system-test.yml ]
then
    docker-compose -f /home/voltha/compose/docker-compose-min-system-test.yml rm -f
fi
if [ -f /home/voltha/compose/docker-compose-system-test.yml ]
then
    docker-compose -f /home/voltha/compose/docker-compose-system-test.yml rm -f
fi
if [ -f /home/voltha/compose/docker-compose-local-auth-test.yml ]
then
    docker-compose -f /home/voltha/compose/docker-compose-local-auth-test.yml rm -f
fi
#
# TODO: Need to add support for the following
#       - Move  mock into a compose file
#       - Support kubernetes