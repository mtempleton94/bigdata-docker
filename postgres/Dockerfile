FROM postgres:9.6

MAINTAINER Mitchell Templeton <mitchelltempleton94@gmail.com>

#===============================================
# Copy Scripts and Config to Container
#===============================================
COPY entrypoint.sh /
RUN chmod 765 /entrypoint.sh
COPY pg_hba.conf /

#===============================================
# Run
#===============================================
ENTRYPOINT ["/entrypoint.sh"]
CMD ["run-postgres"]
