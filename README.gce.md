# Google cloud platform

Create a k8s cluster in GKE gui, then authenticate:

```shell
# GCE users
$ gcloud container clusters get-credentials cluster-1 --zone us-central1-a --project MYPROJECT
```

# Install premetheus-operator 

## Using helm

```shell
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'      
helm init --service-account tiller --upgrade
helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/
helm install coreos/prometheus-operator --name prometheus-operator --namespace monitoring
```

## Enable access to NodePort

```shell
gcloud config set project MYPROJECT
gcloud compute firewall-rules create prometheus --allow tcp:30900,tcp:30902,tcp:30903
# Get public IPs of the nodes
gcloud compute instances list
```
