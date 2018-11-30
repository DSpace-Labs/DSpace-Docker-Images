FROM solr:latest
EXPOSE 8983 8983

WORKDIR /opt/solr/server/solr/
USER solr
RUN mkdir dspace-cores && \
    cp -r configsets/_default dspace-cores/authority && \
    mkdir dspace-cores/authority/data &&\
    cp -r configsets/_default dspace-cores/oai && \
    mkdir dspace-cores/oai/data &&\
    cp -r configsets/_default dspace-cores/search && \
    mkdir dspace-cores/search/data &&\
    cp -r configsets/_default dspace-cores/statistics && \
    mkdir dspace-cores/statistics/data

COPY --chown=solr:solr solr-overlay dspace-cores/
WORKDIR /opt/solr
