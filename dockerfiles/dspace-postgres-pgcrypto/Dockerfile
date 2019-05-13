# This will be deployed as dspace/dspace-postgres-pgcrpyto:latest
FROM postgres

ENV POSTGRES_DB dspace
ENV POSTGRES_USER dspace
ENV POSTGRES_PASSWORD dspace

COPY install-pgcrypto.sh /docker-entrypoint-initdb.d/
