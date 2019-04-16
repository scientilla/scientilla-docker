FROM node:9-alpine

WORKDIR /usr/src/scientilla

COPY docker/web/development/scripts/development.sh /usr/src/scripts/

RUN apk update && \
 apk add --no-cache git make gcc g++ python

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/main" >> /etc/apk/repositories && \
 apk update && \
 apk add --no-cache postgresql-client

RUN npm install -g yarn
RUN yarn --ignore-engines global add mocha
RUN yarn --ignore-engines global add sails
RUN yarn --ignore-engines global add bower
RUN yarn --ignore-engines global add grunt
RUN yarn --ignore-engines global add grunt-cli

EXPOSE 1337
EXPOSE 35732