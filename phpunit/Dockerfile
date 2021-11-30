#wpphptests
FROM wordpress:php7.4-apache
RUN apt-get update
RUN apt-get -y install subversion git mariadb-server
RUN pecl install xdebug

COPY install-wp-tests.sh /install-wp-tests.sh
RUN service mariadb start && mysqladmin -u root password 'root' && /install-wp-tests.sh


WORKDIR "/tmp"
RUN git clone https://github.com/Yoast/PHPUnit-Polyfills.git
RUN curl -LO https://phar.phpunit.de/phpunit-7.5.20.phar && mv phpunit-7.5.20.phar /usr/local/bin/phpunit 
RUN chmod +x /usr/local/bin/phpunit
RUN echo "zend_extension = xdebug.so" >> /usr/local/etc/php/php.ini-development && \
	echo "xdebug.mode=coverage" >> /usr/local/etc/php/php.ini-development && \
	cp /usr/local/etc/php/php.ini-development  /usr/local/etc/php/php.ini


RUN echo "define('WP_TESTS_PHPUNIT_POLYFILLS_PATH', '/tmp/PHPUnit-Polyfills/');" >> wordpress-tests-lib/wp-tests-config.php

WORKDIR "/root"
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp
RUN wp core download --force --allow-root
RUN service mariadb start && \
	wp core config --dbname=wp_tests --dbuser=root --dbpass=root --dbhost=127.0.0.1 --dbprefix=wp_ --allow-root &&\
	wp core install --url=http://localhost:8080 --title=Test --admin_user=admin --admin_email=root@email.com --allow-root

RUN echo 'alias wp="wp --allow-root"' >> /root/.bashrc

WORKDIR "/root/wp-content"
ENTRYPOINT service mariadb start && bash