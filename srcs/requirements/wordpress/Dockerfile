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
    mariadb-client

# Install wp-cli (WordPress Command Line Interface) for automated setup
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create WordPress directory
WORKDIR /var/www/wp

# Copy entrypoint script TO DO
COPY tools/wordpress_script.sh /bin/wordpress_script.sh
RUN chmod +x /bin/wordpress_script.sh

EXPOSE 9000

ENTRYPOINT ["/bin/wordpress_script.sh"]
CMD ["php-fpm83", "-F"]
