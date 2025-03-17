#!/bin/sh

# wait for mariadb to be ready
until mysqladmin ping -h mariadb --silent; do #check if host is enough or if better add user and psw
	echo "Waiting for database..."
	sleep 2
done

if ! wp core is-installed --allow-root; then
	echo "Installing wordpress..."

	# download wordpress
	wp core download --path=/var/www/wp \
					 --allow-root

	# generate wp-config.php with DB settings
	wp config create --path=/var/www/wp \
					 --dbname=$MARIADB_NAME \
					 --dbuser=$MARIADB_USER \
					 --dbpass=$MARIADB_USER_PSW \
					 --dbhost=mariadb \
					 --allow-root

	# install wordpress
	wp core install --path=/var/www/wp \
					--url=$WORDPRESS_URL \
					--title=$WORDPRESS_TITLE \
					--admin_user=$WORDPRESS_ADMIN_USER \
					--admin_password=$WORDPRESS_ADMIN_PASSWORD \
					--admin_email=$WORDPRESS_ADMIN_EMAIL \
					--allow-root

	# create an extra user
	wp user create $WORDPRESS_USER \
				   $WORDPRESS_USER_EMAIL \
				   --user_pass=$WORDPRESS_USER_PASSWORD \
				   --role=author \
				   --path=/var/www/wp \
				   --allow-root

	echo "Wordpress installation completed"
else
	echo "Wordpress is already installed"
fi

exec "$@"