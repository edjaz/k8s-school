set -e
set -x

CLOUD=petasky
if [ -z "$CLOUD" ]; then
    >&2 echo "ERROR: export CLOUD env variable (values: 'sbg' or 'petasky')"
fi

DIR=$(cd "$(dirname "$0")"; pwd -P)
# Create configuration
SSH_CFG="$DIR/../dot-ssh"
KUBE_CFG="$DIR/../dot-kube"
mkdir -p "$SSH_CFG" "$KUBE_CFG"
cp "$DIR/config.$CLOUD"/ssh_config "$SSH_CFG/config"
