quickSetup:
	docker-compose exec django /bin/bash -c "cd /var/www && django-admin startproject pjdir"
	docker-compose exec django /bin/bash -c "cd /var/www/pjdir && python manage.py startapp app"
	docker-compose exec django cp -p /etc/nginx/uwsgi_params /var/www/pjdir/
	docker-compose exec postgres psql -U postgres -f /tmp/postgresInit.sql
	docker-compose exec django /etc/init.d/nginx start
	docker-compose exec django /usr/local/bin/uwsgi --ini /etc/uwsgi/uwsgi.ini

dockerUpdate:
	docker-compose exec django /etc/init.d/nginx start
	docker-compose exec django /usr/local/bin/uwsgi --ini /etc/uwsgi/uwsgi.ini