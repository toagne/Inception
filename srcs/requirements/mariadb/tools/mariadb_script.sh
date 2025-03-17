#!/bin/sh

# Check if MariaDB has been initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Installing MariaDB..."
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    # Initialize the database and set up the root user
    echo "Setting up MariaDB..."
    mysqld --bootstrap --user=mysql --datadir=/var/lib/mysql <<EOF
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PSW}';
CREATE DATABASE ${MARIADB_NAME};
CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_USER_PSW}';
GRANT ALL PRIVILEGES ON ${MARIADB_NAME}.* TO '${MARIADB_USER}'@'%';
DELETE FROM mysql.user WHERE user='';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOF
    echo "MariaDB initialized and database created."
fi

# Start MariaDB server
echo "Starting MariaDB..."
mysqld_safe