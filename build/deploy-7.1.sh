#!/bin/bash
# Apply to Kubernetes
kubectl --kubeconfig=$KUBERNETESCONFIG apply -f yaml-deploy/namespace.yaml
kubectl --kubeconfig=$KUBERNETESCONFIG apply -f yaml-deploy/deployment-7.1.yaml
kubectl --kubeconfig=$KUBERNETESCONFIG apply -f yaml-deploy/service-7.1.yaml