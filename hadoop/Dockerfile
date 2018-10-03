FROM centos

MAINTAINER Mitchell Templeton <mitchelltempleton94@gmail.com>

USER root

#===============================================
# Hadoop Version
#===============================================
ENV HADOOP_VER 2.8.1

#===============================================
# Required Packages
#===============================================
RUN yum update -y; 
RUN yum install -y http://mirror.centos.org/centos/7/os/x86_64/Packages/java-1.8.0-openjdk-devel-1.8.0.161-2.b14.el7.x86_64.rpm 
RUN yum install -y vim 
RUN yum install -y wget
RUN yum install -y which
RUN yum install -y openssh-clients
RUN yum install -y openssh-server
RUN yum install -y openssl
RUN yum clean all

#===============================================
# Environment Variables
#===============================================
ENV HADOOP_HOME /opt/hadoop
ENV HADOOP_PREFIX $HADOOP_HOME
ENV HADOOP_COMMON_HOME $HADOOP_HOME
ENV HADOOP_COMMON_LIB_NATIVE $HADOOP_PREFIX/lib/native
ENV HADOOP_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV HADOOP_LOG_DIR=$HADOOP_HOME/logs
ENV YARN_CONF_DIR $HADOOP_CONF_DIR
ENV PATH $HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-2.b14.el7.x86_64/jre

#===============================================
# HDFS User
#===============================================
WORKDIR /opt/docker
RUN useradd -p $(echo "hdfs" | openssl passwd -1 -stdin) hdfs
RUN groupadd supergroup
RUN usermod -a -G supergroup hdfs

#===============================================
# Hadoop
#===============================================
COPY hadoop-2.8.1.tar.gz . 
RUN tar -xvf hadoop-$HADOOP_VER.tar.gz -C ../
RUN mv ../hadoop-$HADOOP_VER $HADOOP_HOME

#===============================================
# SSH Configuration
#===============================================
#ADD ./config/ssh /root/.ssh/config
#RUN chmod 600 /root/.ssh/config
#RUN chown root /root/.ssh/config

#===============================================
# Hadoop Configuration
#===============================================
#COPY ./config/core-site.xml /opt/hadoop/etc/hadoop/core-site.xml
#COPY ./config/hadoop-env.sh /opt/hadoop/etc/hadoop/hadoop-env.sh
#COPY ./config/hdfs-site.xml /opt/hadoop/etc/hadoop/hdfs-site.xml 
#COPY ./config/mapred-site.xml /opt/hadoop/etc/hadoop/mapred-site.xml

#===============================================
# HDFS Directories
#===============================================
#RUN rm -rf /hdfs
RUN mkdir -p /hdfs
RUN chown -R hdfs /hdfs
RUN chown hdfs /opt/hadoop

#===============================================
# Start HDFS
#===============================================
USER hdfs
RUN mkdir -p $HADOOP_HOME/logs
RUN hdfs namenode -format
RUN start-dfs.sh

USER root

#===============================================
# Ports
#===============================================
# Expose Ports for NameNode
  # 50070 | Web UI for HDFS
  # 50470 | HTTP Service
  # 50090 | Secondary NameNode (HTTP)
  # 50091 | Secondary NameNode (HTTPS)
  # 50100 | NameNode Backup
  # 50105 | NameNode Backup (HTTP)
  # 8020  | Filesystem Metadata
EXPOSE 50070 50470 50090 50100 50105

# Expose Ports for DataNodes
  # 40475 | HTTP Service
  # 50010 | Data Transfer
  # 50020 | IPC Server
  # 50075 | HTTP Server
EXPOSE 40475 50010 50020 50075

# Expose Ports for JournalNode
  # 8485 | RPC
  # 8480 | HTTP Server
  # 8481 | HTTPS Server
EXPOSE 8485 8480 8481

# Expose Ports for MapReduce
  # 50030 | JobTracker Web UI
  # 50060 | TaskTracker Web UI
  # 13562 | ShuffleHandler
  # 10020 | JobHistory Server IPC
  # 19888 | JobHistory Server Web UI
EXPOSE 50030 50060 13562 10020 19888

# Expose Ports for Yarn
  # 8030  | Scheduler Address
  # 8031  | ResourceManager - Tracker
  # 8032  | ResourceManager - Applications Manager
  # 8088  | ResourceManager Web UI (HTTP)
  # 8090  | ResourceManager Web UI (HTTPS)
  # 8040  | NodeManager - Localizer IPC
  # 8042  | NodeManager - Web UI
  # 8046  | NodeManager - Shared Cache
  # 8047  | Admin Interface in Shared Cache
  # 8188  | Timeline Server Web UI (HTTP)
  # 8190  | Timeline Server Web UI (HTTPS)
  # 8788  | Web Application in Shared Cache
  # 10200 | Timeline Server
EXPOSE 8030 8031 8032 8040 8042 8046 8047 8088 8090 8188 8190 8788 10200

# Expose other ports
  # 21 | FTP
  # 22 | SSH
EXPOSE 21 22

#===============================================
# Volume
#===============================================
VOLUME ["/hdfs"]

#===============================================
# Entrypoint
#===============================================
COPY entrypoint.sh /
CMD ["/entrypoint.sh"]

