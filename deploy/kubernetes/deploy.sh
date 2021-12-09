#!/bin/bash

set -e

if [ "$EUID" -eq 0 ]
  then echo "Run without sudo/root"
  exit
fi

NC='\033[0m'
RED='\033[0;31m'

deploy () {
    echo "Deploying sock-shop namespace"
    kubectl create -f manifests/sock-shop-ns.yaml

    echo "Deploying sock-shop core"
    kubectl apply $(ls manifests/*[[:digit:]]*.yaml | awk ' { print " -f " $1 } ')

    echo "Deploying sock-shop-mizu extras"
    kubectl apply $(ls manifests/extras/*[[:digit:]]*.yaml | awk ' { print " -f " $1 } ')

    echo "Deploying monitoring namespace"
    kubectl create -f manifests-monitoring/00-monitoring-ns.yaml

    echo "Deploying Prometheus"
    kubectl apply $(ls manifests-monitoring/*-prometheus-*.yaml | awk ' { print " -f " $1 } ')

    echo "Deploying Grafana"
    kubectl apply $(ls manifests-monitoring/*-grafana-*.yaml | awk ' { print " -f " $1 }' | grep -v grafana-import)

    # wait for Grafana to be ready
    while [[ $(kubectl get pods -l app=grafana -l component=core -n monitoring -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for grafana core pod" && sleep 2; done

    echo "Importing Grafana Dashboards"
    kubectl apply -f manifests-monitoring/23-grafana-import-dash-batch.yaml

    # TODO: Forward Grafana and Prometheus ports
    # Grafana: 3000:$NODE_IN_CLUSTER:31300
    # Prometheus: 9090:$NODE_IN_CLUSTER:31090

    echo -e "sock-shop is running, you can access through front-end service: ${RED}\"$(kubectl get svc -l name=front-end -n sock-shop | awk ' { print $4 } ')\"${NC}"
}

# Check kubectl and current cluster context
echo -e "Deploy sock-shop to ${RED}\"$(kubectl config current-context)\"${NC} cluster"
read -p "Continue (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  deploy
else
  exit
fi