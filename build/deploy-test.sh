#!/bin/bash
# Apply to Kubernetes
kubectl apply -f ../yaml-deploy/deployment-7.1.yaml
kubectl apply -f ../yaml-deploy/service-7.1.yaml
kubectl apply -f ../yaml-deploy/deployment-7.2.yaml
kubectl apply -f ../yaml-deploy/service-7.2.yaml
kubectl apply -f ../yaml-deploy/deployment-7.3.yaml
kubectl apply -f ../yaml-deploy/service-7.3.yaml