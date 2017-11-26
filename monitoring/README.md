k8s monitoring
==============

# Install kubernetes dashboard

See https://github.com/kubernetes/dashboard#getting-started
```
# Install dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
# Launch proxy
kubectl proxy
```
Dashboard is now available on your host at:
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

Eventually get a token to authenticate in kubernetes dashboard:
https://github.com/kubernetes/dashboard/wiki/Access-control#getting-token-with-kubectl

```shell
kubectl -n kube-system get secret
kubectl -n kube-system describe secret default-token-wjck5
```

# Prometheus

## Installation procedure

```
cd scripts 
git clone --single-branch --depth=1 -b master https://github.com/coreos/prometheus-operator.git;
cd prometheus-operator/contrib/kube-prometheus
./hack/cluster-monitoring/deploy
```

## Removal procedure

```
kubectl delete svc -n kube-system kube-controller-manager-prometheus-discovery
kubectl delete svc -n kube-system kube-dns-prometheus-discovery
kubectl delete svc -n kube-system kube-scheduler-prometheus-discovery
./hack/cluster-monitoring/teardown
kubectl delete svc -n monitoring prometheus-operated
kubectl delete svc -n monitoring alertmanager-operated
```

## Access Web UI

## Via a k8s node

Prometheus services are available on each k8s nodes, but not master.

```
# Get docker node ip
IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kube-node-1)
firefox http://$IP:30903/
# Use ports number 30900 and 30902 for Prometheus and AlertManager UIs
```

**REMARK: an http load balancer should be used here, for example `ingress`.**

# Install heapster (influxDB setup)

Current documentation is based on https://github.com/kubernetes/heapster/blob/master/docs/influxdb.md
(note that datasource InfluxDb is already created in grafana)

```
cd scripts 
git clone --single-branch --depth=1 https://github.com/kubernetes/heapster.git
cd heapster/
```

## Create services

```
kubectl create -f deploy/kube-config/influxdb/
kubectl create -f deploy/kube-config/rbac/heapster-rbac.yaml
```

## Access grafana web application

See heapster patch, and use endpoints because of dind setup.

# Display kube-state-metrics

Deployed by prometheus

Based on https://github.com/kubernetes/kube-state-metrics

> See https://github.com/kubernetes/kube-state-metrics#kube-state-metrics-vs-heapster
> for understanding difference between kube-state-metrics, heapster and
> prometheus

# Display metrics

```
IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kube-master)
firefox $IP:8080/metrics
```

