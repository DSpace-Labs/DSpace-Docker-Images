FROM eclipse/ubuntu_jdk8
EXPOSE 4403 8000 8080 9876 22

LABEL che:server:8080:ref=tomcat8 che:server:8080:protocol=http che:server:8000:ref=tomcat8-debug che:server:8000:protocol=http che:server:9876:ref=codeserver che:server:9876:protocol=http

ENV DSPACE_INSTALL=/home/user/dspace
ENV ANT_VERSION 1.10.2
ENV ANT_HOME /home/user/ant-$ANT_VERSION
ENV PATH $ANT_HOME/bin:$PATH


RUN mkdir $ANT_HOME && \
    wget -qO- "https://www.apache.org/dist/ant/binaries/apache-ant-$ANT_VERSION-bin.tar.gz" | tar -zx --strip-components=1 -C $ANT_HOME 

RUN mkdir $DSPACE_INSTALL
RUN mkdir $DSPACE_INSTALL/upload

RUN ln -s $DSPACE_INSTALL/webapps/xmlui /home/user/tomcat8/webapps/xmlui
RUN ln -s $DSPACE_INSTALL/webapps/jspui /home/user/tomcat8/webapps/jspui
RUN ln -s $DSPACE_INSTALL/webapps/rest /home/user/tomcat8/webapps/rest
RUN ln -s $DSPACE_INSTALL/webapps/oai /home/user/tomcat8/webapps/oai
RUN ln -s $DSPACE_INSTALL/webapps/sword /home/user/tomcat8/webapps/sword
RUN ln -s $DSPACE_INSTALL/webapps/swordv2 /home/user/tomcat8/webapps/swordv2
RUN ln -s $DSPACE_INSTALL/webapps/rdf /home/user/tomcat8/webapps/rdf
RUN ln -s $DSPACE_INSTALL/webapps/solr /home/user/tomcat8/webapps/solr

RUN ln -s $DSPACE_INSTALL/webapps/spring-rest /home/user/tomcat8/webapps/spring-rest

ENV JAVA_OPTS=-Xmx500m