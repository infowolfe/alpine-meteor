set -e

export PYTHONPATH=/usr/lib/python2.7/
export GYP_DEFINES="linux_use_gold_flags=0"

BINARY_MODULES=$(find /app -name 'binding\.gyp' -exec dirname {} \; | grep -v fibers)
DIR=$PWD

echo "Start rebuild node modules.."
echo $DIR

for BINARY_MODULE in $BINARY_MODULES; do
    cd $BINARY_MODULE
    echo "node-gyp rebuilding in $BINARY_MODULE"
    node-gyp rebuild
    cd $DIR
done

echo "END rebuild node modules.."
