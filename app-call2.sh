#!/bin/bash
if [ $# -eq 0 ]; then
   ip=localhost
else
   ip=$1
fi
curl -s -H "Content-Type: application/json; charset=UTF-8" -H "Accept:application/json" "http://$ip:8882/csp/myapp/history" --user "appuser:sys" | python3 -mjson.tool
