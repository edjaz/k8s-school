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


## GCE: 

```shell
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'      
helm init --service-account tiller --upgrade
helm install coreos/prometheus-operator --name prometheus-operator --namespace monitoring
```

