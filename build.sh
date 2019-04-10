#!/bin/bash
docker build ./build --no-cache -t dpmeister/irisdemo:simple --build-arg COMMIT_ID=$(git show -s --format=%H)
# docker push dpmeister/irisdemo:simple
