# k8s-school


```shell
# Install dind cluster
wget https://cdn.rawgit.com/Mirantis/kubeadm-dind-cluster/master/fixed/dind-cluster-v1.8.sh

# Get configuration file from dind cluster
$ docker cp kube-master:/etc/kubernetes/admin.conf  ~/src/k8s-school/kubeconfig

# Get examples
$ cd kubectl/scripts
$ git clone https://github.com/kubernetes-up-and-running/examples.git
```

# Exercices

## Install dashboard

## Play with examples

## Install 2 example apps:
https://github.com/kubernetes/examples/blob/master/README.md

## Install Prometheus
