#!/bin/sh

# Debug: Log start of script
echo "$(date) - Starting database creation script."

# Check if MariaDB is initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "$(date) - Initializing MariaDB database."
	mysql_install_db --user=$DB_USER --datadir=/var/lib/mysql
else
	echo "$(date) - MariaDB already initialized."
fi


echo "$(date) - Creating database and user for WordPress."
cat << EOF > /etc/mysql/init.sql
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF



echo "$(date) - MariaDB bootstrapped. Starting full server..."

exec mysqld

# Debug: Log completion of script
echo "$(date) - Database creation script completed."
