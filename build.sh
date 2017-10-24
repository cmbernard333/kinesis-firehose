#!/bin/bash
. ./param_sub.sh

CONFIGS=()
CONFIG_FILE=""
TAGS=()
LATEST_TAG=automox/firehose:latest
RUN=false
CACHE=""
for i in "$@"
do
case ${i} in
    -f=*|--file=*)
    CONFIG_FILE="${i#*=}"
    echo $CONFIG_FILE
    shift
    ;;
    # configs to replace in a properties file
    -c=*|--config=*)
    CONFIGS+=("${i#*=}")  # -c key,val
    shift
    ;;
   -t=*|--tag=*)
    TAGS+=("${i}")
    shift # past argument=value
    ;;
    -r|--run)
    RUN=true
    shift
    ;;
    -n|--no-cache)
    CACHE="--no-cache"
    shift
    ;;
    *)
            # unknown option
    ;;
esac
done

# default values
TAGS+=("-t $LATEST_TAG")
DOCKERFILE=Dockerfile
TAGS_STR=$( IFS=$' '; echo "${TAGS[*]}" )

# param substitution
param_replace ${CONFIG_FILE} "${CONFIGS[@]}"

docker stop firehose && docker rm firehose
docker build ${CACHE} ${TAGS_STR} -f "${DOCKERFILE}" .
if [ "${RUN}" = "true" ]; then
    # mounting docker volume 'rsyslog-remote' to /var/run/rsyslog/dev to get access to the 'log' socket
    docker run -d --name firehose --mount src=rsyslog-remote,dst=/var/run/rsyslog $LATEST_TAG
fi

