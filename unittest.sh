#!/bin/bash 
sudo rm -fR external-vol-db/*
sudo rm -fR external-vol-mgr/*
sudo chown 51773:51773 external-vol-db
sudo chown 51773:51773 external-vol-mgr
docker-compose up -d
docker-compose exec -T iris bash -c "\$ISC_PACKAGE_INSTALLDIR/dev/Cloud/ICM/waitISC.sh '' 60"
docker-compose exec -T iris bash -c "iris session iris -U MYAPP < /home/irisowner/cos/unittest.cos"
teststatus=$?
printf '\nExit status from unittests:'$teststatus'\n'

docker-compose down -v
# docker-compose push
exit $teststatus