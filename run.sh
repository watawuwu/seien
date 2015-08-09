#!/bin/sh

set -eux

# Settings
#=============================================================================

# does not correspond to the symbolic link
CURRENT_DIR=$(cd $(dirname $0);pwd)
SCRIPT_FILE=`basename ${0}`

# Start-up process the delegation
#=============================================================================

#bash ${CURRENT_DIR}/docker.sh -n "stage" -f "${CURRENT_DIR}/docker-compose-stage.yml" "$*"
bash ${CURRENT_DIR}/docker.sh -n "local" -f "${CURRENT_DIR}/docker-compose-local.yml" "$*"
