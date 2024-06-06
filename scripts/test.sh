#!/bin/bash
#
# test.sh - Running Joomla System Test
#   scripts/test.sh
#   scripts/test.sh tests/System/integration/site/components/com_contact/Categories.cy.js
#
# MIT License, Copyright (c) 2024 Heiko Lübbe
# https://github.com/muhme/joomla-drone-system-tests

echo '*** Running System Tests'

# Running all or having one test specification?
if [ $# -eq 0 ] ; then
    # workaround before fix https://github.com/joomla/joomla-cms/issues/43622
    # delete file 'configuration.php' in folder cmsPath=/tests/www/cmysql
    docker exec -it phpmin-system-mysql bash -c 'rm -f /tests/www/cmysql/configuration.php'

    # script arguments are:
    #   JOOMLA_BASE=$1 – /root/www
    #   TEST_GROUP=$2 – cmysql
    #   DB_ENGINE=$3 – mysqli
    #   DB_HOST=$4 – mysql
    docker exec -it phpmin-system-mysql bash -c 'cd /root/www && bash tests/System/drone-system-run.sh /root/www cmysql mysqli mysql'
else  
    docker exec -it phpmin-system-mysql bash -c "cd /root/www; \
        npx cypress run --spec=$1 --browser=firefox --e2e \
            --env cmsPath=/tests/www/cmysql,db_type=mysqli,db_host=mysql,db_password=joomla_ut,db_prefix=cmysql_ \
            --config baseUrl=http://localhost/cmysql,screenshotsFolder=/root/www/tests/System/output/screenshots"
fi
