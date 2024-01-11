FROM debian:latest


RUN apt-get update -y  && \
    apt-get upgrade -y && \
    apt install php-fpm php-mysql -y

RUN sudo apt-get install curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

MKDIR var/www/

RUN wp cli update && \
    wp core download --path=var/www/html