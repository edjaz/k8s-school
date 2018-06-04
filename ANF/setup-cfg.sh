set -e
set -x

CLOUD=petasky
if [ -z "$CLOUD" ]; then
    >&2 echo "ERROR: export CLOUD env variable (values: 'sbg' or 'petasky')" 
fi

DIR=$(cd "$(dirname "$0")"; pwd -P)
# Create configuration
mkdir -p ../dot-kube
cp "$DIR/config.$CLOUD"/ssh_config ../dot-ssh
cp "$DIR/config.$CLOUD"/env-infrastructure.sh ../dot-kube
