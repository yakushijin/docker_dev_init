FROM mysql:8.0
USER root

RUN apt-get update
RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

ENV MYSQL_ROOT_PASSWORD=rootPassword!
ENV MYSQL_DATABASE=pjdb
ENV MYSQL_USER=admin_user
ENV MYSQL_PASSWORD=adminPassword1!
ENV BIND-ADDRESS=0.0.0.0

COPY ./confs/my.cnf /etc/mysql/conf.d/my.cnf
