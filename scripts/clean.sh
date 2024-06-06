#!/bin/bash
#
# clean.sh - delete all docker compose containers
#
#            option "all" – delete also all volumes, network and images AND folders cypress-cache and www
#
# MIT License, Copyright (c) 2024 Heiko Lübbe
# https://github.com/muhme/joomla-drone-system-tests

echo '*** Removing docker compose containers'
if [ $# -eq 1 ] && [ "$1" = "all" ] ; then
  # remove all docker compose containers
  docker compose down
  echo '*** remove all volumes'
  docker compose down --volumes
  echo '*** remove all networks'
  docker network prune -f
  echo '*** remove all images'
  docker compose down --rmi all
  echo '*** remove folders www and cypress-cache'
  rm -rf www cypress-cache
else
  docker compose ps --format '{{.Names}}' | xargs -r docker rm -f
fi
