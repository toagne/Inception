FROM alpine:3.20.3

# Install necessary dependencies
RUN apk update && apk add --no-cache \
    curl \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-mbstring \
    php83-xml \
    php83-curl \
    php83-gd \
    php83-json \
    php83-zip \
    mariadb-client

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create WordPress directory
WORKDIR /var/www/html

# Copy entrypoint script TO DO
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm83", "-F"]
