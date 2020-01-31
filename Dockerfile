FROM centos:6.8

RUN yum install -y wget; yum install -y unzip; yum upgrade -y; yum update -y;  yum clean all
RUN yum install -y java-1.8.0-openjdk-devel.x86_64
RUN yum install -y openssl; yum install -y openssh; yum install -y openssh-clients; yum install -y openssh-server passwd


## Set correct environment variables.
ENV	LANG en_US.UTF-8
ENV	LC_ALL en_US.UTF-8
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk.x86_64

RUN mkdir ~/.ssh; ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa; cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys; chmod 0600 ~/.ssh/authorized_keys

## hadoop 

ENV HADOOP_VER 3.1.2
ENV HIVE_VER 3.1.2
ENV TEZ_VER 0.9.2

ENV HADOOP_ROOT="/opt/hadoop"
ENV HADOOP_HOME="${HADOOP_ROOT}/hadoop-3.1.2"
ENV TEZ_HOME="${HADOOP_ROOT}/tez-0.9.2"
ENV HIVE_HOME="${HADOOP_ROOT}/hive-3.1.2"
ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root"
ENV HDFS_SECONDARYNAMENODE_USER="root"
ENV YARN_RESOURCEMANAGER_USER="root"
ENV YARN_NODEMANAGER_USER="root"

RUN DIR=$(mktemp -d) && cd ${DIR} && \
              curl -Os http://archive.apache.org/dist/hadoop/common/hadoop-3.1.2/hadoop-${HADOOP_VER}.tar.gz && \
              tar xzvf hadoop-${HADOOP_VER}.tar.gz && \
              mv hadoop-${HADOOP_VER} $HADOOP_HOME&& \
              rm -rf ${DIR}

RUN DIR=$(mktemp -d) && cd ${DIR} && \
              curl -Os http://mirror.navercorp.com/apache/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz && \
              tar xzvf apache-hive-${HIVE_VER}-bin.tar.gz && \
              mv apache-hive-${HIVE_VER}-bin $HIVE_HOME && \
              rm -rf ${DIR}

RUN DIR=$(mktemp -d) && cd ${DIR} && \
              curl -Os http://mirror.navercorp.com/apache/tez/0.9.2/apache-tez-${TEZ_VER}-bin.tar.gz && \
              tar xzvf apache-tez-${TEZ_VER}-bin.tar.gz && \
              mv apache-tez-${TEZ_VER}-bin $TEZ_HOME && \
              rm -rf ${DIR}


COPY ./hadoop/* ${HADOOP_HOME}/etc/hadoop/
COPY ./hive/* ${HIVE_HOME}/conf/

RUN mkdir -p /tmp/hadoop-root/dfs/name

RUN /opt/hadoop/hadoop-3.1.2/bin/hdfs namenode -format

RUN /opt/hadoop/hadoop-3.1.2/bin/hadoop dfs -mkdir /user/tez
RUN /opt/hadoop/hadoop-3.1.2/bin/hadoop dfs -put $TEZ_HOME/share/tez.tar.gz /user/tez

# tez
RUN /opt/hadoop/hadoop-3.1.2/sbin/start-yarn.sh

# hive
RUN cp hive-env.sh /opt/hadoop/hive-3.1.2/conf/
RUN cp hive-site.sh /opt/hadoop/hive-3.1.2/conf/
RUN /opt/hadoop/hive-3.1.2/bin/schematool -initSchema -dbType derby

# entry point list
#ENTRYPOINT ["java"]
#RUN /opt/hadoop/hadoop-3.1.2/sbin/start-dfs.sh
# RUN service sshd start 
