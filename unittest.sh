#!/bin/bash 
docker-compose up -d
docker-compose exec irissvc bash -c "\$ISC_PACKAGE_INSTALLDIR/dev/Cloud/ICM/waitISC.sh '' 10"
docker-compose exec irissvc bash -c "iris session iris -U MYAPP < unittest.cos"
printf '\nExit status:'$?'\n'

docker-compose down -v
# docker-compose push
