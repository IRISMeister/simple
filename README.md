# simple
You will be prompted to change your password for the first time you access management portal.  

## prep
Install docker compose plugin.

```bash
$ sudo apt-get update
$ sudo apt-get install docker-compose-plugin
```

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
## To access SMP
Use _SYSTEM / SYS as a credential.

## To stop/run
```
# docker compose stop
# docker compose start
```
## To completely remove (including databases)
```
# ./down.sh
# sudo rm -fR external-vol-*/*
```

If you want to generate skeleton classes from a given openapi spec, do the following.   
Please make sure you have at least one IRIS user (such as SuperUser) enabled and then use it.
```
# curl -H 'Content-Type: application/json' -d @swagger.json -u SuperUser:password http://localhost:52773/api/mgmnt/v2/myapp/MyApp
```
