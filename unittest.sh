#!/bin/bash 
docker-compose up -d
docker-compose exec -T irissvc bash -c "\$ISC_PACKAGE_INSTALLDIR/dev/Cloud/ICM/waitISC.sh '' 10"
docker-compose exec -T irissvc bash -c "iris session iris -U MYAPP < unittest.cos"
teststatus=$?
printf '\nExit status from unittests:'$teststatus'\n'

docker-compose down -v
# docker-compose push
exit $teststatus