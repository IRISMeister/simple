#!/bin/bash
curl -H "Content-Type: application/json; charset=UTF-8" -H "Accept:application/json" "http://localhost:52773/csp/myapp/history" --user "SuperUser:sys" | python -mjson.tool
