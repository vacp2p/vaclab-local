#!/bin/bash
VMETRICS_NAMESAPACE="vmetrics"
VLOGS_NAMESPACE="victorialogs"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VMETRICS_VALUES_FILE="$SCRIPT_DIR/vmetrics.values.yaml"
VLOGS_VALUES_FILE="$SCRIPT_DIR/vlogs.values.yaml"

# Restart Traefik to apply the new sysctl settings
echo "[INFO] Waiting for Traefik deployment to be ready..."
kubectl -n kube-system rollout status deployment/traefik
echo "[INFO] Restarting Traefik deployment..."
kubectl -n kube-system rollout restart deployment/traefik
echo "[INFO] Restarting svclb-traefik pods..."
kubectl -n kube-system delete pod -l svccontroller.k3s.cattle.io/svcname=traefik || true
echo "[INFO] Waiting for Traefik to come back..."
kubectl -n kube-system rollout status deployment/traefik

# Deploy Victoria Metrics using Helm
echo "[INFO] Deploying Victoria Metrics with values file: ${VMETRICS_VALUES_FILE}"
helm repo add vm https://victoriametrics.github.io/helm-charts/
helm repo update
kubectl create namespace "${VMETRICS_NAMESAPACE}" || true
helm install vmks vm/victoria-metrics-k8s-stack -f ${VMETRICS_VALUES_FILE} -n ${VMETRICS_NAMESAPACE} --debug

# Deploy Vicoria Logs using Helm
echo "[INFO] Deploying Victoria Logs with values file: ${VLOGS_VALUES_FILE}"
kubectl create namespace "${VLOGS_NAMESPACE}" || true
helm install vls vm/victoria-logs-single -f ${VLOGS_VALUES_FILE} -n ${VLOGS_NAMESPACE} --debug