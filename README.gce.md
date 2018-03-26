# Google cloud platform

```shell
# GCE users
$ gcloud container clusters get-credentials cluster-1 --zone us-central1-a --project backup-155022

# Upgrade account (useful to install kube-prometheus)
gcloud info | grep Account
grant cluster-admin youraccount@gcloud
kubectl create clusterrolebinding myname-cluster-admin-binding --clusterrole=cluster-admin --user=youraccount@gcloud

```

## Pre-requisite for premetheus-operator

```shell
gcloud info | grep Account
grant cluster-admin youraccount@gcloud
kubectl create clusterrolebinding myname-cluster-admin-binding
--clusterrole=cluster-admin --user=youraccount@gcloud
```

