#!/bin/bash
# Apply to Kubernetes
kubectl --kubeconfig=$KUBERNETESCONFIG apply -f yaml-deploy/namespace.yaml
kubectl --kubeconfig=$KUBERNETESCONFIG apply -f yaml-deploy/deployment-7.4.yaml
kubectl --kubeconfig=$KUBERNETESCONFIG apply -f yaml-deploy/service-7.4.yaml
kubectl --kubeconfig=$KUBERNETESCONFIG apply -f yaml-deploy/ingress-7.4.yaml
kubectl --kubeconfig=$KUBERNETESCONFIG apply -f yaml-deploy/certificate-7.4.yaml