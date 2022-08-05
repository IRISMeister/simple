#!/bin/bash 
docker-compose -f docker-compose-unittest.yml up -d
docker-compose -f docker-compose-unittest.yml exec -T iris bash -c "\$ISC_PACKAGE_INSTALLDIR/dev/Cloud/ICM/waitISC.sh '' 60"
docker-compose -f docker-compose-unittest.yml exec -T iris bash -c "iris session iris -U MYAPP < /home/irisowner/cos/unittest.cos"
teststatus=$?
printf '\nExit status from unittests:'$teststatus'\n'

# copy JUnit style result.
docker-compose -f docker-compose-unittest.yml exec -T iris cat result.xml > result.xml
docker-compose -f docker-compose-unittest.yml down -v
exit $teststatus