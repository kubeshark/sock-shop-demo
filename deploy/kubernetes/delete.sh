#!/bin/bash

set -e

if [ "$EUID" -eq 0 ]
  then echo "Run without sudo/root"
  exit
fi

NC='\033[0m'
RED='\033[0;31m'

delete () {
    echo "Deleting sock-shop namespace resources"
    kubectl delete deployments -n sock-shop --all
    kubectl delete services -n sock-shop --all
    kubectl delete pods -n sock-shop --all
    kubectl delete daemonset -n sock-shop --all
    kubectl delete namespace sock-shop

    echo "Deleting monitoring namespace resources"
    kubectl delete deployments -n monitoring --all
    kubectl delete services -n monitoring --all
    kubectl delete pods -n monitoring --all
    kubectl delete daemonset -n monitoring --all
    kubectl delete namespace monitoring
}

# Check kubectl and current cluster context
echo -e "Delete sock-shop from ${RED}\"$(kubectl config current-context)\"${NC} cluster"
read -p "Continue (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  delete
else
  exit
fi