#wait for mariadb to be up
sleep 10


#install wordpress
if [ ! -f /var/www/html/wp-config.php ]; then
	wp config create --allow-root \
		--dbname=$SQL_NAME \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 --path='var/www/wordpress'

	wp core install --url=$domain_name \
		--title=$brand\
		--admin_user=$wp_admin \
		--admin_password=$wp_admin_pwd \
		--admin_email=$wp_admin_email \
		--allow-root

	wp user create $login $wp_user_email\
		--role=author \
		--user_pass=$wp_user_pwd\
		--allow-root

fi

usr/sbin/php-fpm7.3 -F
