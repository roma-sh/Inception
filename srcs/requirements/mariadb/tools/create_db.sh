#!bin/sh

# we already ran the MariaDB service in the Dockerfile, and here we double check that
if [ ! -d "/var/lib/mysql/mysql" ]; then

		# changes the owner and group
		# -R means apply changes recursively to all files inside /var/lib/mysql
		chown -R mysql:mysql /var/lib/mysql

		# init database
		mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm
fi


# This part creates a temporary SQL script (create_db.sql) with several commands to
# set up your MariaDB (MySQL) environment
if [ ! -d "/var/lib/mysql/wordpress" ]; then

		cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM     mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}';
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
		# run init.sql
		/usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
		rm -f /tmp/create_db.sql
fi


# USE mysql; – This tells MySQL to use the mysql system database where user accounts and privileges are stored.
# FLUSH PRIVILEGES; – This command forces MySQL to reload the privilege tables, ensuring any changes made to user privileges take effect.
# DELETE FROM mysql.user WHERE User=''; – This removes any users that have no username, which is a security measure.
# DROP DATABASE test; – This deletes a default database called test, which is often not needed.
# DELETE FROM mysql.db WHERE Db='test'; – This removes the privilege entries for the test database.
# DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1'); – This removes any
	# root users that are allowed to connect from anything other than localhost (your own computer), 127.0.0.1, or ::1 (IPv6 localhost).
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}'; – This changes the password for the root user to the
	# value of the environment variable ${DB_ROOT} (which you should have set elsewhere).
# CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci; – This creates a new database for
	# WordPress, with a character set of utf8 and collation for general character comparison.
# CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}'; – This creates a new user for accessing the
	# WordPress database with the username ${DB_USER} and the password ${DB_PASS} (again, these should be set elsewhere).
# GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%'; – This grants the new user all privileges (permissions) on the WordPress database.
# FLUSH PRIVILEGES; – Again, this reloads the privileges to ensure the changes take effect.


# /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
# This command runs the MySQL server in "bootstrap" mode, meaning it processes the
# SQL commands in the file /tmp/create_db.sql. These commands set up the user, database,
# and privileges, just as we've described earlier.


