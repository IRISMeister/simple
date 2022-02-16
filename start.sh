#!/bin/bash
sudo rm -fR external-vol-db/*
sudo rm -fR external-vol-mgr/*
sudo chown 51773:51773 external-vol-db
sudo chown 51773:51773 external-vol-mgr
docker-compose up -d
