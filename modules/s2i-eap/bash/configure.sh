#!/bin/sh
# Configure module
set -e

SCRIPT_DIR=$(dirname $0)
ARTIFACTS_DIR=${SCRIPT_DIR}/artifacts

chown -R jboss:root $SCRIPT_DIR
chmod -R ug+rwX $SCRIPT_DIR
chmod ug+x ${ARTIFACTS_DIR}/usr/local/s2i/*

# Legacy location required by s2i tooling.
ln -s /usr/local/s2i /usr/libexec/s2i

pushd ${ARTIFACTS_DIR}
cp -pr * /
popd