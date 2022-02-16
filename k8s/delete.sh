#!/bin/bash
microk8s kubectl delete -f simple.yml --wait
microk8s kubectl delete pvc -l app=iris
