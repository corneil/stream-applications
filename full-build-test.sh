#!/usr/bin/env bash
SCDIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
SCDIR=$(realpath $SCDIR)
if [ "$BUILD_VERSION" = "" ]; then
  source $SCDIR/get-build-version-params.sh
fi
$SCDIR/build-core.sh "-T 1C install -Psnapshot -Pintegration"
$SCDIR/build-folder.sh ./applications/processor,./applications/sink,./applications/source,./applications/stream-applications-integration-tests,stream-applications-release-train "-T 1C install -Psnapshot -Pintegration"
$SCDIR/build-folder.sh ./applications/stream-applications-integration-tests "verify -Dspring.cloud.stream.applications.version=${BUILD_VERSION} -Psnapshot -Pintegration"
