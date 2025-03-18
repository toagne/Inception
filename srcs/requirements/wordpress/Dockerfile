FROM alpine:3.20.3

# Install necessary dependencies
RUN apk update && apk add --no-cache \
    curl \
    php83 \
    php83-phar \
    php83-fpm \
    php83-mysqli \
    php83-curl \
    php83-zip \
    php83-mbstring \
    mariadb-client

# Install wp-cli (WordPress Command Line Interface) for automated setup
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Set up the working directory where WordPress will be installed
WORKDIR /var/www/wp

# Create the PHP-FPM user (www-data is typically the user running PHP-FPM)
RUN adduser -D -H -s /sbin/nologin -g www-data -G www-data www-data

# Create the PHP configuration file
RUN echo "memory_limit=512M" > /etc/php83/php.ini

# mone
COPY conf/www.conf /etc/php83/php-fpm.d/www.conf

# Copy entrypoint script
COPY tools/wordpress_script.sh /bin/wordpress_script.sh
RUN chmod +x /bin/wordpress_script.sh

EXPOSE 9000

ENTRYPOINT ["/bin/wordpress_script.sh"]
CMD ["php-fpm83", "-F"]