FROM solr:latest
EXPOSE 8983 8983

WORKDIR /opt/solr/server/solr/
COPY --chown=solr:solr solr/ dspace-cores
WORKDIR /opt/solr
