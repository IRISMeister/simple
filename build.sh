#!/bin/bash
export COMMIT_ID=$(git show -s --format=%H)
docker-compose build