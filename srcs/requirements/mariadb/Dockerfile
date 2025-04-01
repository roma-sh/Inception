FROM alpine:3.21

ARG DB_NAME \
	DB_USER \
	DB_PASS \
	DB_ROOT

# install the service
RUN apk update && apk add --no-cache mariadb mariadb-client

# create the directory where mariadb temp files will stored and our database
RUN mkdir /var/run/mysqld && \
	chmod 777 /var/run/mysqld

COPY ./requirements/mariadb/conf/mariadb.conf /etc/my.cnf.d/mariadb-server.conf

# (run mariadb)explanations down
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Tells Docker that MariaDB will use port 3306 for communications
EXPOSE 3306

COPY requirements/mariadb/tools/create_db.sh .

RUN sh create_db.sh && rm create_db.sh

# Switches the user from root to mysql
USER mysql

CMD ["/usr/bin/mysqld", "--skip-log-error"]


# mysql_install_db is a MariaDB (MySQL) tool that creates the necessary system
# tables inside the database. These system tables store important information such as:

# User accounts
#Permissions
# Metadata about databases

# --user=mysql: The mysql user is the default system user that MariaDB runs as,
# It has limited permissions and only owns database files , meaning:
# 1-The database files won't be owned by root, reducing security risks.
# 2-MariaDB can safely access the database files during operation.
# Imagine if MariaDB ran as root instead:
	# If someone hacks MariaDB, they would gain full control of the server.
	# MariaDB would be able to modify any file on the system.
	# A bug in MariaDB could cause major damage to system files.

# --datadir=/var/lib/mysql
# This specifies where the database files should be stored.
# /var/lib/mysql is the default location for MariaDB databases in most Linux distributions.
# Inside this folder, MariaDB will create:
	# Tables
	# User account information
	# System databases

