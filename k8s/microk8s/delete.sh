#!/bin/bash
microk8s kubectl delete -f simple.yml
microk8s kubectl delete pvc dbv-data-iris-0 dbv-mgr-iris-0
