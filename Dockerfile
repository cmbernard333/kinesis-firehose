# Create a minial ubuntu image that runs rsyslogd
# Latest ubuntu LTS
FROM amazonlinux:latest
RUN yum -y update && yum install -y aws-kinesis-agent file findutils
ENV JAVA_HOME /usr/lib/jvm/jre-1.7.0-openjdk.x86_64
ENV KINESIS_LOGLEVEL "INFO"
# ENV KINESIS_LOGFILE "/var/log/aws-kinesis-agent/aws-kinesis-agent.log"
ENV KINESIS_LOGFILE "/dev/stdout"
# environment variables needed to talk the kinesis stream instance in AWS
# ENV AWS_ACCESS_KEY_ID
# ENV AWS_SECRET_ACCESS_KEY
# ENV AWS_DEFAULT_REGION
# copy all the configuration information into the right place
COPY src/etc/aws-kinesis/agent.json /etc/aws-kinesis/
COPY firehose-entrypoint.sh /
# start firehouse
ENTRYPOINT [ "/firehose-entrypoint.sh" ]
CMD /usr/bin/start-aws-kinesis-agent -L ${KINESIS_LOGLEVEL} -l ${KINESIS_LOGFILE}
