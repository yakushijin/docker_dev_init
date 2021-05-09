FROM php:7.4-fpm-buster
USER root
WORKDIR /tmp

RUN apt-get update
RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

RUN apt-get install -y zip unzip git curl gnupg2 ca-certificates lsb-release
RUN echo "deb http://nginx.org/packages/debian `lsb_release -cs` nginx" | tee /etc/apt/sources.list.d/nginx.list
RUN curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add -
RUN apt-get update
RUN apt-get -y install nginx

COPY ./confs/nginx.conf /etc/nginx/nginx.conf
COPY ./confs/laravel.conf /etc/nginx/conf.d/default.conf

RUN sed -i "s/user = www-data/user = nginx/" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = nginx/" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/expose_php = On/expose_php = Off/" /usr/local/etc/php/php.ini-development
RUN mkdir -p /var/run/php-fpm/
RUN sed -i "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm\/php-fpm.sock/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/listen = 9000/listen = \/var\/run\/php-fpm\/php-fpm.sock/g" /usr/local/etc/php-fpm.d/zz-docker.conf
RUN sed -i "s/;listen.owner = www-data/listen.owner = nginx/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/;listen.group = nginx/listen.group = nginx/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/;listen.mode = 0660/listen.mode = 0660/g" /usr/local/etc/php-fpm.d/www.conf

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt install -y nodejs && npm update -g

RUN docker-php-ext-install pdo_mysql

ENTRYPOINT [ "bash","-ce","php-fpm -D \nnginx -g 'daemon off;'" ]

# 開発時に使用
RUN apt-get -y install vim
RUN pecl install xdebug &&  docker-php-ext-enable xdebug
RUN apt-get install net-tools
