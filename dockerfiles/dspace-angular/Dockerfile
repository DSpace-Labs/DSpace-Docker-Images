FROM alpine/git as clone
ARG DSPACE_BRANCH=master
ENV DSPACE_GIT https://github.com/DSpace/DSpace-angular.git

WORKDIR /app

RUN git clone ${DSPACE_GIT} \
    && cd /app/DSpace-angular \
    && git checkout ${DSPACE_BRANCH}

FROM node:8
WORKDIR /app
COPY --from=clone /app/DSpace-angular /app
EXPOSE 3000

RUN cd /app
RUN yarn install
CMD yarn start
