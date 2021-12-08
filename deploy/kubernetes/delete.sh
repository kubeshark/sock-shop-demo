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
    kubectl delete all --all -n sock-shop
    kubectl delete namespace sock-shop || true

    echo "Deleting monitoring namespace resources"
    kubectl delete all --all -n monitoring
    kubectl delete namespace monitoring || true

    echo "Deleting default namespace resources"
    kubectl delete all --all
}

# Check kubectl and current cluster context
echo -e "Delete sock-shop from ${RED}\"$(kubectl config current-context)\"${NC} cluster"
read -p "Continue (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  delete
else
  exit
fi