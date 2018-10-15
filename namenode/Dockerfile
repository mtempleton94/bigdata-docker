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
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]

