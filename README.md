# simple
You will be prompted to change your password for the first time you access management portal.  

## To build
```
# ./build.sh
```
## To test
```
# ./unittest.sh
```
## To run
```
# ./start.sh
```
## To test api calls
```
# ./app-call1.sh
# ./app-call2.sh
```
## To stop/run
```
# ./docker-compose stop
# ./docker-compose start
```
## To completely remove
```
# ./down.sh
```

If you want to generate skeleton classes from a given openapi spec, do the following.   
Please make sure you have at least one IRIS user (such as SuperUser) enabled and then use it.
```
# curl -H 'Content-Type: application/json' -d @swagger.json -u SuperUser:password http://localhost:52773/api/mgmnt/v2/myapp/MyApp
```
