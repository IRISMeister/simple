#!/bin/bash -e

docker-compose up -d
# comment out below lines if you want to externalize user database file(s).
#docker-compose exec irissvc bash -c "\$ISC_PACKAGE_INSTALLDIR/dev/Cloud/ICM/waitISC.sh '' 30"
#./externalize.sh