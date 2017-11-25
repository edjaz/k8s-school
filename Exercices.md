# k8s-school


```shell
# Install dind cluster
wget https://cdn.rawgit.com/Mirantis/kubeadm-dind-cluster/master/fixed/dind-cluster-v1.8.sh

# Get configuration file from dind cluster
$ docker cp kube-master:/etc/kubernetes/admin.conf  ~/src/k8s-school/dot-kube/dindconfig
$ ln -sf ~/src/k8s-school/dot-kube/dindconfig ~/src/k8s-school/dot-kube/config

# GCE users
$ gcloud container clusters get-credentials cluster-1 --zone us-central1-a --project backup-155022
```

# Exercices

## Install dashboard

## Play with examples

## Install 2 example apps:
https://github.com/kubernetes/examples/blob/master/README.md

## Install Prometheus
