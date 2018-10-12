FROM centos

MAINTAINER Mitchell Templeton <mitchelltempleton94@gmail.com> 

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-2.b14.el7.x86_64/jre

RUN yum update -y
RUN yum install -y http://mirror.centos.org/centos/7/os/x86_64/Packages/java-1.8.0-openjdk-devel-1.8.0.161-2.b14.el7.x86_64.rpm wgemt unzip curl vim python-setuptools
RUN yum clean all

CMD ["/bin/bash"]
