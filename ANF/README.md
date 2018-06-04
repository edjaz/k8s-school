# Download keys

At https://drive.uca.fr/d/54734d97770640889165/

Then run:

```shell
mkdir -p k8s-school/dot-ssh
cd k8s-school/dot-ssh
# Copy key here
chmod 600 id_rsa_anf
```

# Setup ssh configuration

```shell
export CLOUD=petasky
./k8s-school/ANF/setup-cfg.sh
```

# Launch kubectl client

Get a bash prompt inside docker image with kubectl client:

```shell
../run-kubectl.sh
```

# Setup k8s cluster

```shell
# Inside kubectl docker image
# Define k8s-orchestrator
# replace kube-node-xxx with your k8s master hostname
export ORCHESTRATOR=kube-node-xxx

# Log in orchestrator
ssh $ORCHESTRATOR

# Create k8s master
# apiserver-cert-extra-sans option is a hack for ssh tunnel
# Official documentation available at:
# https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#instructions
kubeadm init --apiserver-cert-extra-sans=localhost

# Install pod network
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# Log out orchestrator
exit

# Join a node
# replace kube-node-yyy with your k8s node hostname
ssh kube-node-yyy
kubeadm join --token <token> <master-ip>:<master-port> --discovery-token-ca-cert-hash sha256:<hash>

```
