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


# 9 Initialize the MariaDB database with specified user and data directory
# 27 Start the MariaDB server


# we made DB_USER in mariadb service, user in any database is essential for several reasons:
# - User accounts help control who can access the database and what they can do
# - When a user connects to MariaDB, the system authenticates them using a username and password
	# This helps ensure that only the intended person or application can access the database.
# -By creating separate users for different roles or applications (e.g., one user for WordPress and
	# another for backup purposes), you can limit what each user can do. This is crucial for maintaining
	# a secure environment where sensitive data is protected.
# and more like: Database Ownership, Application-Specific Access (wordpress in our case), Audit and Monitoring
