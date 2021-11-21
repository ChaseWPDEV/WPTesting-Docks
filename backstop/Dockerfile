#wpbackstoptests
FROM node:12-stretch
USER root
RUN npm install -g npm
RUN npm install -g backstopjs
RUN mkdir /var/backstop-tests
WORKDIR /var/backstop-tests
ENTRYPOINT bash