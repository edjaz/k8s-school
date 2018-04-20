# Google cloud platform

Create a k8s cluster in GKE gui, then authenticate:

```shell
# GCE users
$ gcloud container clusters get-credentials cluster-1 --zone us-central1-a --project backup-155022
```

# Install premetheus-operator 

```shell
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'      
helm init --service-account tiller --upgrade
helm install coreos/prometheus-operator --name prometheus-operator --namespace monitoring
```

