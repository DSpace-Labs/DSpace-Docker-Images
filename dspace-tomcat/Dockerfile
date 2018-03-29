FROM tomcat:8

ENV DSPACE_INSTALL=/dspace
ENV JAVA_OPTS=-Xmx2000m

RUN ln -s ${DSPACE_INSTALL}/webapps/solr        /usr/local/tomcat/webapps/solr
RUN ln -s ${DSPACE_INSTALL}/webapps/xmlui       /usr/local/tomcat/webapps/xmlui
RUN ln -s ${DSPACE_INSTALL}/webapps/jspui       /usr/local/tomcat/webapps/jspui
RUN ln -s ${DSPACE_INSTALL}/webapps/rest        /usr/local/tomcat/webapps/rest
RUN ln -s ${DSPACE_INSTALL}/webapps/oai         /usr/local/tomcat/webapps/oai
RUN ln -s ${DSPACE_INSTALL}/webapps/rdf         /usr/local/tomcat/webapps/rdf
RUN ln -s ${DSPACE_INSTALL}/webapps/sword       /usr/local/tomcat/webapps/sword
RUN ln -s ${DSPACE_INSTALL}/webapps/swordv2     /usr/local/tomcat/webappsswordv2

RUN ln -s ${DSPACE_INSTALL}/webapps/spring-rest /usr/local/tomcat/webapps/spring-rest
