FROM node:9-alpine

WORKDIR /usr/src/

RUN apk update && \
 apk add --no-cache git make gcc g++ python bash

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/main" >> /etc/apk/repositories && \
 apk update && \
 apk add --no-cache postgresql-client

ARG GIT_BRANCH

RUN git clone https://github.com/scientilla/scientilla.git scientilla

WORKDIR /usr/src/scientilla/

RUN git fetch origin ${GIT_BRANCH}

RUN git checkout ${GIT_BRANCH}

COPY docker/web/production/scientilla.js ./config/

RUN cp views/layout.ejs.dist views/layout.ejs

RUN npm install -g yarn

RUN chmod +x /usr/local/bin/yarn

RUN yarn install

RUN yarn global add bower

RUN bower install --allow-root

RUN yarn global add sails
RUN yarn global add grunt
RUN yarn global add grunt-cli

EXPOSE 1337