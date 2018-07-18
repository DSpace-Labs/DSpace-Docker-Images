FROM tomcat:8
EXPOSE 8080 8009

ENV ANT_VERSION 1.10.4
ENV ANT_HOME /tmp/ant-$ANT_VERSION
ENV PATH $ANT_HOME/bin:$PATH

RUN mkdir $ANT_HOME && \
    wget -qO- "https://www.apache.org/dist/ant/binaries/apache-ant-$ANT_VERSION-bin.tar.gz" | tar -zx --strip-components=1 -C $ANT_HOME

ENV DSPACE_INSTALL=/dspace
ENV JAVA_OPTS=-Xmx2000m

RUN ln -s $DSPACE_INSTALL/webapps/solr        /usr/local/tomcat/webapps/solr
RUN ln -s $DSPACE_INSTALL/webapps/xmlui       /usr/local/tomcat/webapps/xmlui
RUN ln -s $DSPACE_INSTALL/webapps/jspui       /usr/local/tomcat/webapps/jspui
RUN ln -s $DSPACE_INSTALL/webapps/rest        /usr/local/tomcat/webapps/rest
RUN ln -s $DSPACE_INSTALL/webapps/oai         /usr/local/tomcat/webapps/oai
RUN ln -s $DSPACE_INSTALL/webapps/rdf         /usr/local/tomcat/webapps/rdf
RUN ln -s $DSPACE_INSTALL/webapps/sword       /usr/local/tomcat/webapps/sword
RUN ln -s $DSPACE_INSTALL/webapps/swordv2     /usr/local/tomcat/webapps/swordv2

RUN ln -s $DSPACE_INSTALL/webapps/spring-rest /usr/local/tomcat/webapps/spring-rest
