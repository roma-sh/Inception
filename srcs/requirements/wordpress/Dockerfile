FROM alpine:3.21

ARG	DB_NAME \
	DB_USER \
	DB_PASS


RUN apk update && apk upgrade && apk add --no-cache \
	php \
	php-fpm \
	php-mysqli \
	php-json \
	php-dom \
	php-exif \
	php-redis \
	php-mbstring \
	php-fileinfo \
	php-curl \
	php-xml \
	php-openssl \
	php-zip \
	wget \
	unzip

# to see each why we nee all these modules, check out wordpress Documentations:
	# https://make.wordpress.org/hosting/handbook/server-environment/

COPY ./requirements/wordpress/conf/php.conf /etc/php8/php-fpm.d/www.conf
# ##########changed########

# download wordpress and unzip it along the path /var/www/.

WORKDIR /var/www

RUN wget https://wordpress.org/latest.zip && \
	unzip latest.zip && \
	# mv wordpress/* . && rm -rf wordpress chat
	cp -rf wordpress/* . && \
	rm -rf wordpress latest.zip

COPY ./requirements/wordpress/conf/wp-config-create.sh .

RUN sh wp-config-create.sh && rm wp-config-create.sh && \
	chmod -R 0777 wp-content/

# CMD ["sh", "-c", "/usr/sbin/php-fpm8 -F"] chat
CMD ["/usr/sbin/php-fpm83", "-F"]
