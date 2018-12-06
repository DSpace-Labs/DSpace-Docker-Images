FROM solr:latest
EXPOSE 8983 8983

WORKDIR /opt/solr

COPY ./dspaceInit-entrypoint.sh /
COPY ./schema-mods/ /tmp/
