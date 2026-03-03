#!/bin/bash
docker compose up -d
# wait unitl IRIS is ready
docker compose exec -T iris bash -c "\$ISC_PACKAGE_INSTALLDIR/dev/Cloud/ICM/waitISC.sh '' 60"
# Loading sample data (in order to load them into database outside of a container)
docker compose exec iris iris session iris -U MYAPP "##class(MyApp.Utils).LoadCSV()"
