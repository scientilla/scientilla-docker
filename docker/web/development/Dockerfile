FROM node:9-alpine

WORKDIR /usr/src/scientilla

RUN apk update && \
 apk add --no-cache git make gcc g++ python

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/main" >> /etc/apk/repositories && \
 apk update && \
 apk add --no-cache postgresql-client

RUN npm install -g mocha
RUN npm install -g bower
RUN npm install -g grunt
RUN npm install -g grunt-cli

EXPOSE 1337
EXPOSE 35732