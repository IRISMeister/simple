#!/bin/bash
kubectl delete -f simple.yml
kubectl delete pvc dbv-data-iris-0 dbv-mgr-iris-0
