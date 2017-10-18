#!/bin/bash
TAGS=()
RUN=false
for i in "$@"
do
case ${i} in
   -t=*|--tag=*)
    TAGS+=("${i#*=}")
    shift # past argument=value
    ;;
    -r|--run)
    RUN=true
    shift
    ;;
    *)
            # unknown option
    ;;
esac
done

# default values
TAGS+=("-t automox/firehose:latest")

# operating system check
DOCKERFILE=Dockerfile

TAGS_STR=$( IFS=$' '; echo "${TAGS[*]}" )

docker stop firehose && docker rm firehose
docker build --no-cache $TAGS_STR -f "${DOCKERFILE}" .
if [ "${RUN}" = "true" ]; then
    docker run -d --name firehose automox/firehose:latest
fi

