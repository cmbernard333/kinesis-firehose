# Create a minial ubuntu image that runs rsyslogd
# Latest ubuntu LTS
FROM amazonlinux:latest
RUN yum -y update && yum install -y aws-kinesis-agent file
ENV JAVA_HOME /usr/lib/jvm/jre-1.7.0-openjdk.x86_64
ENV KINESIS_LOGLEVEL $KINESIS_LOGLEVEL
ENV KINESIS_LOGFILE $KINESIS_LOGFILE
# copy all the configuration information into the right place
# COPY src/etc/aws-kinesis/agent.json /etc/aws-kinesis/
# need a config file that removes the /dev/xconsole redirect as the docker container doesn't have it
# start firehouse
# ENTRYPOINT [ "/usr/bin/start-aws-kinesis-agent", "-L", "$KINESIS_LOGLEVEL", "-l", "$KINESIS_LOGFILE" ]
