# simple

## To build
```
$ ./build.sh
```
## To test
```
$ ./unittest.sh
```
## To run
```
$ ./up.sh
```

In order to have a look at Durable Sys folders, do...

```
sudo ls external-vol-mgr/IRIS_conf.d/
```

## To test api calls
```
$ ./app-call1.sh
$ ./app-call2.sh
```

## To access tables

```
$ docker compose exec iris iris sql iris -U MYAPP
SQL Command Line Shell
----------------------------------------------------

The command prefix is currently set to: <<nothing>>.
Enter <command>, 'q' to quit, '?' for help.
[SQL]MYAPP>>select * from PERSON
```

## To access SMP

http://localhost:8882/csp/sys/%25CSP.Portal.Home.zen

Use _SYSTEM / SYS as a credential.

## To stop/run
```
$ docker compose stop
$ docker compose start
```
## To completely remove (including databases)
```
$ ./down.sh
$ sudo rm -fR external-vol-*/*
```

If you want to generate skeleton classes from a given openapi spec, do the following.   
Please make sure you have at least one IRIS user (such as SuperUser) enabled and then use it.
```
$ curl -H 'Content-Type: application/json' -d @swagger.json -u SuperUser:SYS http://localhost:8882/api/mgmnt/v2/myapp/MyApp
```
