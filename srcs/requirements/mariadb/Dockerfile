FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y \
    mariadb-server \
    mariadb-client 

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d

RUN mkdir -p var/run/mysqld && chown mysql:mysql /var/run/mysqld && chmod 755 /var/run/mysqld

RUN mkdir -p /tmp/
COPY ./tools/mysql.sh /tmp/mysql.sh
RUN chmod +x /tmp/mysql.sh

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

CMD ["/tmp/mysql.sh"]