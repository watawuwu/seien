#!/bin/sh

set -eux

# Settings
#=============================================================================

# does not correspond to the symbolic link
CURRENT_DIR=$(cd $(dirname $0);pwd)
SCRIPT_FILE=`basename ${0}`
NAME=${SCRIPT_FILE%.*}
PROJECT_PREFIX="seien"
SETTGIN_YML=${CURRENT_DIR}/${NAME}".yml"

# Args
################################################################################

while getopts "n:f:" OPT
do
  case ${OPT} in
    \? )
      exit;;
    "f")
      SETTGIN_YML="${OPTARG}"
      if [ ! -f "${SETTGIN_YML}" ]
      then
        echo -e "\033[1;34m Not found yml file.\033[m"
        eixt 1;
      fi
      ;;
    "n")
      NAME="${OPTARG}"
      ;;
  esac
done


PROJECT_NAME=${PROJECT_PREFIX}-${NAME}

# removed the optional argument
shift $(( ${OPTIND} - 1 ))

# If there is no argument re-created in the background start
COMMAND="up -d"
if [ $# -ge 1 ] && [ ! -z "$*" ]
then
  COMMAND="$*"
fi

# Pre Initialization
################################################################################

# Initialization of the log directory
# @todo no good
DATA_DIR="/data/$PROJECT_PREFIX"
sudo mkdir -p ${DATA_DIR}/data/application
sudo mkdir -p ${DATA_DIR}/data/percona5.6

sudo mkdir -p ${DATA_DIR}/log/memcached1.4
sudo mkdir -p ${DATA_DIR}/log/td-agent2
sudo mkdir -p ${DATA_DIR}/log/application
sudo mkdir -p ${DATA_DIR}/log/nginx1.8
sudo mkdir -p ${DATA_DIR}/log/percona5.6

# Launch a docker
################################################################################

docker-compose -f ${SETTGIN_YML} -p ${PROJECT_NAME} ${COMMAND}
docker ps
