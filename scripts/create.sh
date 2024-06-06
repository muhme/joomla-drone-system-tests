#!/bin/bash -e
#
# create.sh - Create three docker containers and prepare Joomla installation from source code
#
# MIT License, Copyright (c) 2024 Heiko Lübbe
# https://github.com/muhme/joomla-drone-system-tests

echo "*** Docker compose up"
docker compose build --no-cache
docker compose up -d

# Use 'n lts' to upgrade node from v16 to v20, otherwise 'npm ci' will fail
docker exec -it phpmin-system-mysql bash -c " \
cd /root/www && \
cp cypress.config.dist.js cypress.config.js ; \
npm install -g n && \
n lts && \
composer update && \
npm ci"
