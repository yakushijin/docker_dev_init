FROM  nginx:latest

# 503ページ
# COPY ./confs/503.conf /etc/nginx/conf.d/default.conf
COPY ./confs/nginx.conf /etc/nginx/nginx.conf
