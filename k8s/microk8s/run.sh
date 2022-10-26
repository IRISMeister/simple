#!/bin/bash
microk8s kubectl apply -f simple.yml
microk8s kubectl get pod -l app=my-iris
microk8s kubectl get statefulset -o wide
microk8s kubectl logs iris-0
