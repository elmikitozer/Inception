FROM debian:buster

RUN apt update \
	&& apt-get -y install wget

RUN apt-get install -y php7.3 \
	php-cgi \
	php-fpm \
	php-mysql \
	php-fpm \
	php-pdo \
	php-gd php-cli \
	php-mbstring \
	redis \
	php-redis \
	mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

RUN wget https://fr.wordpress.org/wordpress-6.7.1-fr_FR.tar.gz -P /var/www

RUN cd /var/www \
	&& tar -xvf wordpress-6.7.1-fr_FR.tar.gz \
	&& rm -rf wordpress-6.7.1-fr_FR.tar.gz

RUN chown -R root:root /var/www/wordpress

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

#Install wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#Givinig the right to execute
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

#Script for wp-cli
COPY ./conf/auto_config.sh .
RUN chmod +x auto_config.sh

ENTRYPOINT [ "bash", "auto_config.sh" ]
