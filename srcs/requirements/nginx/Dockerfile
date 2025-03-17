FROM alpine:3.20.6

RUN apk add --no-cache nginx openssl

RUN mkdir /etc/nginx/cert
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/cert/cert.key \
	-out /etc/nginx/cert/cert.crt \
	-subj "/C=FI/ST=UUSIMA/L=HLSINKI/O=42/OU=HIVE/CN=mpellegr.42.fr"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN adduser -D -H -s /sbin/nologin -g www-data -G www-data www-data

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]