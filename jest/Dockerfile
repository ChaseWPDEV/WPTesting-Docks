#wpjestests
FROM node:12-stretch
RUN npm install -g jest
RUN npm install -g jsdom
RUN mkdir /var/www && mkdir /var/www/html && mkdir /var/www/html/wp-content
WORKDIR /var/www/html/wp-content
ENTRYPOINT bash
