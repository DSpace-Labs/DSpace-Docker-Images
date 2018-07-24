FROM alpine/git as clone
ARG DSPACE_BRANCH=dspace-6_x
ENV DSPACE_GIT https://github.com/DSpace/DSpace.git

WORKDIR /app

RUN git clone ${DSPACE_GIT} \
    && cd /app/DSpace \
    && git checkout ${DSPACE_BRANCH}

COPY local.cfg /app/DSpace
COPY build.properties /app/DSpace

FROM maven as build
WORKDIR /app
COPY --from=clone /app/DSpace /app
RUN mvn package

FROM dspace/dspace-tomcat as ant_build
# Set TARGET_DIR to "dspace-build" for dspace-4_x
ARG TARGET_DIR=dspace-installer
COPY --from=build /app /dspace-src
WORKDIR /dspace-src/dspace/target/${TARGET_DIR}
RUN ant update_configs update_code update_webapps update_solr_indexes

FROM dspace/dspace-tomcat
COPY --from=ant_build /dspace /dspace
RUN /dspace/bin/dspace version
