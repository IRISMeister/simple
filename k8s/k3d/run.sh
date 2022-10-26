#!/bin/bash
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.23/deploy/local-path-storage.yaml

kubectl apply -f simple.yml
kubectl get pod -l app=my-iris
kubectl get statefulset -o wide
kubectl logs iris-0
