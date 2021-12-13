#wpphptests
FROM php:7.4.25-cli-bullseye
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions bcmath xdebug mysqli exif gd imagick zip


RUN apt-get update
RUN apt-get -y install subversion git mariadb-server

COPY install-wp-tests.sh /install-wp-tests.sh
RUN service mariadb start && mysqladmin -u root password 'root' && /install-wp-tests.sh

WORKDIR "/tmp"
RUN curl -LO https://phar.phpunit.de/phpunit-7.5.20.phar && mv phpunit-7.5.20.phar /usr/local/bin/phpunit 
RUN chmod +x /usr/local/bin/phpunit

#composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer
RUN composer require --dev yoast/phpunit-polyfills

RUN echo "require_once('/tmp/vendor/autoload.php');" >> /tmp/wordpress-tests-lib/wp-tests-config.php

WORKDIR "/root"
#wp-cli for pleasant user experience
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp
RUN wp core download --force --allow-root
RUN service mariadb start && \
	wp core config --dbname=wp_tests --dbuser=root --dbpass=root --dbhost=127.0.0.1 --dbprefix=wp_ --allow-root &&\
	wp core install --url=http://localhost:8080 --title=Test --admin_user=admin --admin_email=root@email.com --allow-root

RUN echo 'alias wp="wp --allow-root"' >> /root/.bashrc
RUN echo "xdebug.mode=coverage" >> /usr/local/etc/php/php.ini-development && \
	cp /usr/local/etc/php/php.ini-development  /usr/local/etc/php/php.ini

WORKDIR "/root/wp-content"
ENTRYPOINT service mariadb start && bash