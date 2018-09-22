# Fork this repository and clone it

Create a github account to fork this repository, then clone it:
```shell
mkdir -p $HOME/src
cd $HOME/src
git clone https://github.com/<GIT-USER>/k8s-school.git
```

# Download keys

At https://drive.google.com/open?id=18Z6sQCwfe0LAzFtloC1AjhYPmpRgNyHZ 

Then run:

* Linux

```shell
mkdir -p k8s-school/dot-ssh
cd k8s-school/dot-ssh
# Move keys here
chmod 600 id_rsa_sch
cd ..
```

# Setup ssh configuration

* Linux

```shell
./paas/setup-cfg.sh
```

# Set up kubectl client

Get a bash prompt inside docker image with kubectl client:

* Linux

```shell
./run-kubectl.sh
```

# Setup k8s cluster

```shell
# WARN: Inside kubectl docker image

# Define k8s-orchestrator
# replace kube-node-xxx with your k8s master hostname
export ORCHESTRATOR=kube-node-xxx

# Linux only: Grant access to ssh keys
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
# MacOS only: WARN backup any existing $HOME/.kube/config first!!!
./scripts/paas/export-kubeconfig.sh
# Open ssh tunnel to k8s orchestrator
./scripts/paas/ssh-tunnel.sh

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
