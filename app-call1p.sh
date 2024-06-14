#!/bin/bash
if [ $# -eq 0 ]; then
   ip=localhost
else
   ip=$1
fi
curl -v -X POST -H "Content-Type: application/json; charset=UTF-8" \
-H "Accept: application/json, text/plain, */*" \
-H "Accept-Encoding: gzip, deflate, br, zstd" \
-H "Accept-Language: ja,en-US;q=0.9,en;q=0.8" \
-d '{"Value":"川原"}' "http://$ip:8882/csp/myapp/traditional/post" --user "appuser:sys" 