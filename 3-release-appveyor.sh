#!/bin/bash
set -x
set -e
set -u

cd thrift

CMAKE_BUILD_TYPE="${Configuration}"
INSTALL_DIR="${PROFILE}-${Platform}-${CMAKE_BUILD_TYPE}"
COMMIT_ID="${APPVEYOR_REPO_COMMIT}"

cd "${INSTALL_DIR}"
7z a "../${INSTALL_DIR}.zip" *
cd ..

github-release \
  paulthomson/build-thrift \
  "v-${COMMIT_ID}" \
  "${COMMIT_ID}" \
  "$(echo -e "Automated build.\n$(git log --graph -n 3 --abbrev-commit --pretty='format:%h - %s <%an>')")" \
  "${INSTALL_DIR}.zip"

