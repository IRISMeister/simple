#!/bin/bash
if [ $# -eq 0 ]; then
   ip=localhost
else
   ip=$1
fi
curl -X POST -H "Content-Type: application/json; charset=UTF-8" -H "Accept:application/json" -d '{"Value":"テスト"}' "http://$ip:8882/csp/myapp/post" --user "appuser:sys" 