#!/bin/sh

# wait for mariadb to be ready
until mysqladmin ping -h mariadb --silent; do 
    echo "Waiting for database..."
    sleep 2
done

# Log that we are now ready to install WordPress
echo "MariaDB is ready. Installing WordPress..."

# Ensure the WordPress installation path is clean and empty before downloading
if ! wp core is-installed --path=/var/www/wp --allow-root; then
    echo "Downloading WordPress..."

    # download WordPress if it's not installed
    wp core download --path=/var/www/wp --allow-root

    # generate wp-config.php with DB settings
    wp config create --path=/var/www/wp \
                     --dbname=$MARIADB_NAME \
                     --dbuser=$MARIADB_USER \
                     --dbpass=$MARIADB_USER_PSW \
                     --dbhost=mariadb \
                     --allow-root

    # install WordPress
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

    echo "WordPress installation completed"
else
    echo "WordPress is already installed"
fi

chown -R www-data:www-data /var/www/wp

# Execute the command passed to the container (e.g., php-fpm83 -F)
exec "$@"
