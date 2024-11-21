# FROM alpine:3.19

# RUN apk update \
# 	&& apk add mariadb mariadb-client openrc vim

# # RUN mkdir -p /etc/nginx/ssl \
# # 	&& openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=myevou.42.fr/UID=myevou"

# # RUN mkdir -p var/www/nginx
# COPY conf/my.cnf /etc/my.cnf

# COPY mysql.sh /mysql.sh
# # RUN chmod +x /mysql.sh && /mysql.sh

# # RUN chmod 755 /var/www/nginx
# # # # RUN addgroup -S www-data && adduser -S www-data -G www-data
# # # RUN chown -R www-data:www-data /var/www/nginx
# # RUN getent group www-data || addgroup -S www-data
# # RUN id -u www-data || adduser -S www-data -G www-data
# # RUN chown -R www-data:www-data /var/www/nginx



# # CMD ["mariadb;"]

FROM debian:buster

RUN apt update \
	&& apt install mariadb-server -y

# RUN mkdir -p /etc/nginx/ssl \
# 	&& openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=myevou.42.fr/UID=myevou"

# RUN mkdir -p var/www/nginx
COPY conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY mysql.sh /mysql.sh
RUN chmod +x /mysql.sh && ./mysql.sh

# RUN chmod 755 /var/www/nginx
# # # RUN addgroup -S www-data && adduser -S www-data -G www-data
# # RUN chown -R www-data:www-data /var/www/nginx
# RUN getent group www-data || addgroup -S www-data
# RUN id -u www-data || adduser -S www-data -G www-data
# RUN chown -R www-data:www-data /var/www/nginx



# CMD ["mariadb;"]

