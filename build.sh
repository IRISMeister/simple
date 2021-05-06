#!/bin/bash
export COMMIT_ID=$(git show -s --format=%H)
COMPOSE_DOCKER_CLI_BUILD=1 docker-compose build
