#!/bin/bash
cp prod/pwd.isc prod/etc/
rm -f prod/etc/pwd.isc.done
docker run --init -d --rm --name myiris -h myiris -e TZ=Asia/Tokyo -p 51773:51773 -p 52773:52773 \
       -v $PWD/prod:/ISC \
       dpmeister/irisdemo:simple \
       -p /ISC/etc/pwd.isc
