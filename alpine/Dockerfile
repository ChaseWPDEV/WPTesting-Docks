#wpphptests
FROM wordpress:cli-php7.4
USER root

RUN apk update
RUN apk add --no-cache subversion

COPY install-wp-tests.sh /install-wp-tests.sh
RUN /install-wp-tests.sh

WORKDIR "/tmp"
RUN curl -LO https://phar.phpunit.de/phpunit-7.5.20.phar && mv phpunit-7.5.20.phar /usr/local/bin/phpunit
RUN chmod +x /usr/local/bin/phpunit

#composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer
RUN composer require --dev yoast/phpunit-polyfills
RUN composer require --dev 10up/wp_mock:0.4.2

RUN echo "require_once('/tmp/vendor/autoload.php');" >> /tmp/wordpress-tests-lib/wp-tests-config.php
#ATTENTION: Add your composer packages here!!
WORKDIR "/root"
#wp-cli for pleasant user experience
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN echo 'alias wp="wp --allow-root"' >> /root/.bashrc
RUN echo "xdebug.mode=coverage" >> /usr/local/etc/php/php.ini-development && \
	cp /usr/local/etc/php/php.ini-development  /usr/local/etc/php/php.ini

COPY docker_func.php ./docker_func.php
RUN cat /tmp/wordpress-tests-lib/wp-tests-config.php >> ./docker_func.php && \
	mv ./docker_func.php /tmp/wordpress-tests-lib/wp-tests-config.php

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions xdebug

WORKDIR "/root/wp-content"
