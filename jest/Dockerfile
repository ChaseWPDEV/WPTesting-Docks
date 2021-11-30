#wpjestests
FROM node:12-stretch
RUN npm install -g jest
RUN npm install -g jsdom
RUN mkdir /root/wp-content
WORKDIR /root/wp-content
ENTRYPOINT bash
