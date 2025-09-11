FROM ubuntu/nginx
WORKDIR /var/www/html
RUN apt update -y && \
    apt upgrade -y && \
    apt install -y curl && \
    echo 'Im Alive' > index.html

