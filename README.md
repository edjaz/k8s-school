# k8s-school

# Slides

All materials are [here](https://drive.google.com/open?id=0B-VJpOQeezDjZktuTnlEMEpGMUU)

# Exercices

## Pre-requisites

### Local machine

```shell
# Install dind cluster
wget https://cdn.rawgit.com/Mirantis/kubeadm-dind-cluster/master/fixed/dind-cluster-v1.8.sh

# Get configuration file from dind cluster
$ docker cp kube-master:/etc/kubernetes/admin.conf  ~/src/k8s-school/dot-kube/dindconfig
$ ln -sf ~/src/k8s-school/dot-kube/dindconfig ~/src/k8s-school/dot-kube/config
```

# Google cloud platform

```shell
# GCE users
$ gcloud container clusters get-credentials cluster-1 --zone us-central1-a --project backup-155022

# Upgrade account (useful to install kube-prometheus)
gcloud info | grep Account
grant cluster-admin youraccount@gcloud
kubectl create clusterrolebinding myname-cluster-admin-binding --clusterrole=cluster-admin --user=youraccount@gcloud

```

## Install dashboard

## Play with examples

## Install 2 example apps:
https://github.com/kubernetes/examples/blob/master/README.md

## Install Prometheus
