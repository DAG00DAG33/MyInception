FROM debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt install nginx openssl -y

RUN openssl req \
    -x509 \
    -nodes \
    -days 365 \
    -newkey rsa:4096 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=ES/ST=Spain/L=Spain/O=42 School/OU=digarcia/CN=digarcia/"

# COPY conf/nginx.conf etc/nginx/conf.d/
COPY conf/nginx.conf /etc/nginx/
COPY tools/entrypoint.sh ./

ENTRYPOINT ["bin/bash", "entrypoint.sh"]
#ENTRYPOINT ["nginx", "-g", "daemon off;"]
