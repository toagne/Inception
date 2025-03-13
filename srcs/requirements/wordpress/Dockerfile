FROM alpine:3.20.3

RUN apk update && apk add --no-cache \
	bash \
	wget \
	php83 \
	php83-fpm \
	php83-phar \
	php83-curl \
	php83-cgi \
	php83-mysqli \
	php83-iconv \
	mariadb-client

CMD ["php-fpm83", "-F"]