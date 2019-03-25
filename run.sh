#!/bin/bash
cp prod/pwd.isc prod/etc/
rm -f prod/etc/pwd.isc.done
docker run --rm --name myiris -p 51773:51773 -p 52773:52773 -v /etc/localtime:/etc/localtime:ro -v $PWD/prod:/ISC dpmeister/irisdemo:simple -p /ISC/etc/pwd.isc
