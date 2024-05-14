FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt install mariadb-server -y

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld
RUN mkdir -p /var/lib/mysql

RUN chown -R mysql:mysql /var/run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql
RUN chmod 777 /var/run/mysqld
RUN chmod 777 /var/lib/mysql

COPY tools/entrypoint.sh ./

CMD ["bin/bash", "entrypoint.sh"]