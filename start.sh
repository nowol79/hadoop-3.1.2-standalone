#!/bin/bash

HADOOP_ROOT="/opt/hadoop"
HADOOP_HOME="${HADOOP_ROOT}/hadoop-3.1.2"
TEZ_HOME="${HADOOP_ROOT}/tez-0.9.2"

service sshd start
rm -rf /tmp/hadoop-root
mkdir -p /tmp/hadoop-root/dfs/name

${HADOOP_HOME}/bin/hdfs namenode -format
${HADOOP_HOME}/sbin/start-dfs.sh

sleep 1

${HADOOP_HOME}/bin/hadoop dfs -mkdir -p /user/tez
${HADOOP_HOME}/bin/hadoop dfs -put $TEZ_HOME/share/tez.tar.gz /user/tez

${HADOOP_HOME}/sbin/start-yarn.sh

trap : TERM INT; sleep infinity & wait
