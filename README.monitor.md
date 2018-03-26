k8s monitoring
==============

# Prometheus

## Installation procedure

See https://github.com/coreos/prometheus-operator/blob/master/contrib/kube-prometheus/docs/KOPSonAWS.md

```
# On workstation
WORKDIR=kubectl/scripts/prometheus-operator-temp
git clone --single-branch --depth=1 -b master https://github.com/coreos/prometheus-operator.git $WORKDIR;

# In kubectl container
cd scripts/prometheus-operator-temp/contrib/kube-prometheus/
./hack/cluster-monitoring/deploy
kubectl -n kube-system create -f manifests/k8s/self-hosted/
```

## Removal procedure

```
./hack/cluster-monitoring/teardown
kubectl delete svc -n monitoring prometheus-operated
kubectl delete svc -n monitoring alertmanager-operated
```

## Access Web UI

### Via kubectl proxy

**NOT RECOMMENDED: Prometheus and Grafana Web UIs do not work well using proxy.**

## Via a k8s node

```shell
# Get node ip
# WARN: with dind-cluster grafana is not available in kube-node-1 for unknown reason
IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kube-node-2)

# access services at  http://$IP:30902 (grafana), and 30903, 30900

Prometheus services are available on each k8s nodes.

