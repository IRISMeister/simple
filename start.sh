#!/bin/bash
chmod 777 external-vol-*
docker-compose up -d
# wait unitl IRIS is ready
docker-compose exec -T iris bash -c "\$ISC_PACKAGE_INSTALLDIR/dev/Cloud/ICM/waitISC.sh '' 60"
# Loading sample data
docker-compose exec iris iris session iris -U MYAPP "##class(MyApp.Utils).LoadCSV()"
