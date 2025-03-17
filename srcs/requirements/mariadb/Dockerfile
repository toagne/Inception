FROM alpine:3.20.6

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysql /var/log/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql /var/log/mysql

COPY conf/mariadb.cnf /etc/my.cnf.d/mariadb-server.cnf
RUN chmod 644 /etc/my.cnf.d/mariadb-server.cnf

COPY tools/mariadb_script.sh /bin/mariadb_script.sh
RUN chmod +x /bin/mariadb_script.sh

EXPOSE 3306

CMD ["/bin/mariadb_script.sh"]