#!/bin/bash -e

# change owner form default(root) to iris friendly one.
docker-compose exec -u root irissvc bash -c "mkdir /vol-data/myapp-data; chown -R irisowner:irisuser /vol-data"

# externalize WIJ & user data database. (Code database remains inside a container)
# You can't use this container image for dev environment because MYAPP (routines) are now Read-only because of Durable Sys
docker-compose exec irissvc bash -c "iris session iris -U USER < externalize.cos"
