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

See https://github.com/coreos/prometheus-operator/blob/master/contrib/kube-prometheus/docs/KOPSonAWS.md

```
cd admin-dev 
git clone --single-branch --depth=1 -b master https://github.com/coreos/prometheus-operator.git prometheus-operator-temp;
cd prometheus-operator-temp/contrib/kube-prometheus
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

Prometheus services are available on each k8s nodes. Example below use node
`freel_node_1` with ip `ip_freel_node_1`

```
docker exec -it kube-node-1 bash
ssh -NR 30902:localhost:30902 fjammes@clrinfopc04
# then, on the workstation, access Grafana UI
firefox http://localhost:30903/
# Use ports number 30900 and 30902 for Prometheus and AlertManager UIs
```

**REMARK: an http load balancer should be used here, for example `ingress`.**

# Install heapster (influxDB setup)

Current documentation is based on https://github.com/kubernetes/heapster/blob/master/docs/influxdb.md
(note that datasource InfluxDb is already created in grafana)

```
cd admin-dev 
git clone --single-branch --depth=1 https://github.com/kubernetes/heapster.git
cd heapster/
```

## Create services

```
kubectl create -f deploy/kube-config/influxdb/
kubectl create -f deploy/kube-config/rbac/heapster-rbac.yaml
```

## Access grafana web application

```
# If not already done, start proxy
kubectl proxy

```

1. On your docker host open `http://localhost:8001/api/v1/proxy/namespaces/kube-system/services/monitoring-grafana/?orgId=1`
2. Open the side menu by clicking the Grafana icon in the top header.
3. In the side menu you should find a link named `Sign in`, log in using 'admin', 'admin' credentials.
4. In the side menu named `Home`, choose `Cluster` or `Pods` to get graphs.

# Display kube-state-metrics

Deployed by prometheus

Based on https://github.com/kubernetes/kube-state-metrics

> See https://github.com/kubernetes/kube-state-metrics#kube-state-metrics-vs-heapster
> for understanding difference between kube-state-metrics, heapster and
> prometheus

# Display metrics

On k8s master:
```
docker exec -it kube-master bash
curl localhost:8080/metrics
```

