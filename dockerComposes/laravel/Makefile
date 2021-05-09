quickSetup:
	docker-compose exec laravel composer create-project laravel/laravel --prefer-dist /var/www/pjdir "6.0.*"
	docker-compose exec laravel /bin/bash -c "cd /var/www/pjdir && composer require laravel/ui 1.*"
	docker-compose exec laravel /bin/bash -c "cd /var/www/pjdir && composer update"
	docker-compose exec laravel /bin/bash -c "cd /var/www/pjdir && cp -p .env.example .env"
	docker-compose exec laravel /bin/bash -c "cd /var/www/pjdir && php artisan key:generate"
	docker-compose exec laravel /bin/bash -c "cd /var/www/pjdir && php artisan ui bootstrap --auth"
	docker-compose exec laravel /bin/bash -c "cd /var/www/pjdir && npm install && npm run dev"
	docker-compose exec laravel chmod -R 777 /var/www/pjdir/storage/
	docker restart laravel_host
