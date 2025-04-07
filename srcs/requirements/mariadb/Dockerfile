FROM debian:bullseye

COPY ./requirements/mariadb/tools/create_db.sh .

RUN mkdir -p /docker-entrypoint-initdb.d \
	/run/mysqld \
	/etc/mysql/mariadb.conf.d && chmod +x create_db.sh

RUN apt update && apt upgrade -y && apt install -y \
	mariadb-server \
	curl \
	gettext

COPY ./requirements/mariadb/conf/50-server.cnf /etc/mysql/mariadb.conf.d/

EXPOSE 3306

ENTRYPOINT ["./create_db.sh"]
