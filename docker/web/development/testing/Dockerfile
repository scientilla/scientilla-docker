FROM node:9-alpine

WORKDIR /usr/src/scientilla

RUN apk update && \
 apk add --no-cache git make gcc g++ python bash

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/main" >> /etc/apk/repositories && \
 apk update && \
 apk add --no-cache postgresql-client

RUN npm install -g yarn

RUN chmod +x /usr/local/bin/yarn

RUN yarn global add bower

RUN yarn global add grunt

RUN yarn global add grunt-cli

RUN yarn global add mocha@5.2.0

RUN yarn global add should@11.2.1

EXPOSE 1337
EXPOSE 35732