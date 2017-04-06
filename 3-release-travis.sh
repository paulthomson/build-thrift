#!/bin/bash
set -x
set -e
set -u

cd thrift

INSTALL_DIR="${BUILD_PLATFORM}-${CMAKE_BUILD_TYPE}"
COMMIT_ID="${TRAVIS_COMMIT}"

cd "${INSTALL_DIR}"
zip -r "../${INSTALL_DIR}.zip" *
cd ..

github-release \
  paulthomson/build-thrift \
  "v-${COMMIT_ID}" \
  "${COMMIT_ID}" \
  "$(echo -e "Automated build.\n$(git log --graph -n 3 --abbrev-commit --pretty='format:%h - %s <%an>')")" \
  "${INSTALL_DIR}.zip"


