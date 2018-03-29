FROM tomcat:8

ENV JAVA_OPTS=-Xmx2000m

RUN ln -s /dspace/webapps/solr    /usr/local/tomcat/webapps/solr
RUN ln -s /dspace/webapps/xmlui   /usr/local/tomcat/webapps/xmlui
RUN ln -s /dspace/webapps/jspui   /usr/local/tomcat/webapps/jspui
RUN ln -s /dspace/webapps/rest    /usr/local/tomcat/webapps/rest
RUN ln -s /dspace/webapps/oai     /usr/local/tomcat/webapps/oai
RUN ln -s /dspace/webapps/rdf     /usr/local/tomcat/webapps/rdf
RUN ln -s /dspace/webapps/sword   /usr/local/tomcat/webapps/sword
RUN ln -s /dspace/webapps/swordv2 /usr/local/tomcat/webappsswordv2

RUN ln -s /dspace/webapps/spring-rest /usr/local/tomcat/webapps/spring-rest
