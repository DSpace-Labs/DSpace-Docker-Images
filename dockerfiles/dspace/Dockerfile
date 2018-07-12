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

COPY --from=build /app /dspace-src
WORKDIR /dspace-src/dspace/target/dspace-installer

RUN ant update clean_backups

FROM dspace/dspace-tomcat
COPY --from=ant_build /dspace /dspace
RUN /dspace/bin/dspace version
