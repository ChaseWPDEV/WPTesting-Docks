#wpphptests
FROM wordpress:php7.4-apache
RUN apt-get update
RUN apt-get -y install subversion
RUN apt-get -y install mariadb-server
WORKDIR "/tmp"
RUN apt-get -y install git
RUN git clone https://github.com/Yoast/PHPUnit-Polyfills.git
RUN curl -LO https://phar.phpunit.de/phpunit-7.5.20.phar && mv phpunit-7.5.20.phar /usr/local/bin/phpunit 
RUN chmod +x /usr/local/bin/phpunit
RUN pecl install xdebug
RUN echo "zend_extension = xdebug.so" >> /usr/local/etc/php/php.ini-development && \
	echo "xdebug.mode=coverage" >> /usr/local/etc/php/php.ini-development && \
	cp /usr/local/etc/php/php.ini-development  /usr/local/etc/php/php.ini

COPY install-wp-tests.sh /install-wp-tests.sh
RUN service mariadb start && mysqladmin -u root password 'root' && /install-wp-tests.sh

RUN echo "define('WP_TESTS_PHPUNIT_POLYFILLS_PATH', '/tmp/PHPUnit-Polyfills/');" >> wordpress-tests-lib/wp-tests-config.php
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp
WORKDIR "/var/www/html/wp-content/"
ENTRYPOINT service mariadb start && bash
