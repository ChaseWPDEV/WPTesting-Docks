#wpjestests
FROM node:12-alpine
RUN apk update
RUN apk add --no-cache bash
RUN npm install -g jest jest-cli
RUN npm install -g jsdom
USER node
WORKDIR /home/node

