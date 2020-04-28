REM change owner form default(root) to iris friendly one.
docker-compose exec -u root iris bash -c "mkdir /vol-data/MYAPP-DATA; chown -R irisowner:irisuser /vol-data"

docker-compose exec -T iris bash -c "$ISC_PACKAGE_INSTALLDIR/dev/Cloud/ICM/waitISC.sh '' 10"

REM  externalize user data database. (Code database remains inside a container)
docker-compose exec iris bash -c "iris session iris -U USER < /home/irisowner/cos/externalize.cos"
