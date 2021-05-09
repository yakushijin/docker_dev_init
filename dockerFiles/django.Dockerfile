FROM python:3.8-buster
USER root

RUN apt-get update
RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

RUN apt-get install -y libgl1-mesa-dev
RUN pip3.8 install -U pip
RUN pip3.8 install --upgrade pip
RUN pip3.8 install --upgrade setuptools
RUN pip3.8 install django uwsgi numpy pandas opencv-python pillow psycopg2-binary psycopg2 django-allauth
RUN pip3.8 install ptvsd pylint

RUN apt-get install -y zip unzip git curl gnupg2 ca-certificates lsb-release
RUN echo "deb http://nginx.org/packages/debian `lsb_release -cs` nginx" | tee /etc/apt/sources.list.d/nginx.list
RUN curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add -
RUN apt-get update
RUN apt-get -y install nginx

COPY ./confs/nginx.conf /etc/nginx/nginx.conf
COPY ./confs/django.conf /etc/nginx/conf.d/default.conf

RUN mkdir /etc/uwsgi
RUN mkdir /var/log/uwsgi /var/uwsgi /var/uwsgi/pid /var/uwsgi/sock
RUN chown -R nginx:nginx /var/uwsgi

COPY ./confs/uwsgi.ini /etc/uwsgi/uwsgi.ini

# 開発時に使用
RUN apt-get -y install vim
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt install -y nodejs && npm update -g
RUN pip install pylint

# djangoプロジェクト作成後に起動可能
# ENTRYPOINT [ "bash","-ce","/usr/local/bin/uwsgi --ini /etc/uwsgi/uwsgi.ini & \nnginx -g 'daemon off;'" ]