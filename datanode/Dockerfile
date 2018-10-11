FROM base-hadoop

MAINTAINER Mitchell Templeton <mitchelltempleton94@gmail.com>

#===============================================
# Volume
#===============================================
VOLUME ["/hdfs"]

#===============================================
# Entrypoint
#===============================================
COPY entrypoint.sh /
CMD ["/entrypoint.sh"]

