#wpjestests
FROM node:16.13.1-alpine
RUN apk update
RUN apk add --no-cache bash
RUN npm install -g jest jest-cli
RUN npm install -g jsdom jest-environment-jsdom
USER node
WORKDIR /home/node

