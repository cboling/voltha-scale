#!/bin/sh
docker stop voltha-onu_mock
docker rm voltha-onu_mock

docker-compose -f /home/voltha/compose/docker-compose-min-system-test.yml stop
docker-compose -f /home/voltha/compose/docker-compose-local-auth-test.yml stop

docker-compose -f /home/voltha/compose/docker-compose-min-system-test.yml rm -f
docker-compose -f /home/voltha/compose/docker-compose-local-auth-test.yml rm -f

#
# TODO: Need to add support for the following
#       - Move  mock into a compose file
#       - Support kubernetes