FROM solr:latest
EXPOSE 8983 8983

WORKDIR /opt/solr

COPY --chown=solr:solr dspaceInit.sh .

CMD ./dspaceInit.sh
