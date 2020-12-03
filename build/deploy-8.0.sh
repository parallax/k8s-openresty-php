#!/bin/bash
# Apply to Kubernetes
kubectl --kubeconfig=$KUBERNETESCONFIG apply -f yaml-deploy/namespace.yaml
kubectl --kubeconfig=$KUBERNETESCONFIG apply -f yaml-deploy/deployment-8.0.yaml
kubectl --kubeconfig=$KUBERNETESCONFIG apply -f yaml-deploy/service-8.0.yaml
kubectl --kubeconfig=$KUBERNETESCONFIG apply -f yaml-deploy/ingress-8.0.yaml
kubectl --kubeconfig=$KUBERNETESCONFIG apply -f yaml-deploy/certificate-8.0.yaml