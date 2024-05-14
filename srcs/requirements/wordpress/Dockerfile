FROM debian:bullseye


RUN apt-get update -y  && \
    apt-get upgrade -y && \
    apt install php7.4 php-fpm php-mysql curl mariadb-client -y

# RUN sudo apt-get install curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# MKDIR var/www/
RUN mkdir -p var/www/html
RUN mkdir -p var/www/wordpress

RUN wp --allow-root cli update
RUN wp --allow-root core download --path=var/www/html

# RUN wp config create --allow-root \
#     --dbname=wordpress \
#     --dbuser=root \
#     --dbpass= \
#     --dbhost=localhost \
#     --dbprefix=wp_

RUN mkdir -p /run/php
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/
COPY tools/entrypoint.sh ./

CMD ["bin/bash", "entrypoint.sh"]