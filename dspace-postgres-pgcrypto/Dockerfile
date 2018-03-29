# From https://github.com/DSpace-Labs/dspace-dev-docker/tree/master/postgres
FROM postgres

ENV POSTGRES_DB dspace
ENV POSTGRES_USER dspace
ENV POSTGRES_PASSWORD dspace

COPY install-pgcrypto.sh /docker-entrypoint-initdb.d/