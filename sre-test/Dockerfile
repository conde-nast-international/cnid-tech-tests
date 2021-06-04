FROM node:8-alpine

WORKDIR /srv/app
COPY ./src/package.json ./src/yarn.lock ./
RUN yarn install
COPY ./src/* ./

ENTRYPOINT [ "node", "server.js" ]