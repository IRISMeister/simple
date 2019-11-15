#!/bin/bash
if [ $# -eq 0 ]; then
   ip=localhost
else
   ip=$1
fi
curl -H "Content-Type: application/json; charset=UTF-8" -H "Accept:application/json" "http://$ip:52773/csp/myapp/get" --user "appuser:sys"
