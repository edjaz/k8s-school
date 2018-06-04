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
# Use 'petasky' or 'sbg' depending on your cloud provider
export CLOUD=petasky
./k8s-school/ANF/setup-cfg.sh
```

# Launch kubectl client

Get a bash prompt inside docker image with kubectl client:

```shell
./k8s-school/run-kubectl.sh
```

# Setup k8s cluster

```shell
# Inside kubectl docker image
# Define k8s-orchestrator
# replace kube-node-xxx with your k8s master hostname
export ORCHESTRATOR=kube-node-xxx

# Grant access to ssh keys
chown -R root:root $HOME/.ssh

# Log in orchestrator
ssh $ORCHESTRATOR

# Create k8s master
# apiserver-cert-extra-sans option is a hack for ssh tunnel
# Official documentation available at:
# https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#instructions
sudo kubeadm init --apiserver-cert-extra-sans=localhost

# WARN: record join command:
# example:
# kubeadm join 192.168.56.249:6443 --token h73o12.7r64fz5k0f92er3j \
#   --discovery-token-ca-cert-hash \
#   sha256:f124761234bae63f4806f602a6e6467a10da3c844ff06a4a1c2a7b6ad62dca9d

# Log out orchestrator
exit

# Copy k8s credential to container
./scripts/ANF/export-kubeconfig.sh
# Open ssh tunnel to k8s orchestrator
./scripts/ANF/ssh-tunnel.sh

# Copy configuration and install pod network
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# Check master is ready
kubectl get nodes

# Join a node
# replace kube-node-yyy with your k8s node hostname
ssh kube-node-yyy
sudo kubeadm join --token <token> <master-ip>:<master-port> --discovery-token-ca-cert-hash sha256:<hash>
```

# Install k8s dashboard

See https://github.com/kubernetes/dashboard/ to install it, and https://github.com/kubernetes/dashboard/wiki/Access-control#admin-privileges to grant access right
