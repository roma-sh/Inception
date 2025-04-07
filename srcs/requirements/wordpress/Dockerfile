FROM alpine:3.16

# Install required packages for PHP and WordPress in one step to reduce layers and image size
RUN apk update && apk upgrade && apk add --no-cache \
	php8 \
	mysql-client \
	php8-fpm \
	php8-mysqli \
	php8-json \
	php8-dom \
	php8-exif \
	php8-fileinfo \
	php8-curl \
	php8-xml \
	php8-openssl \
	php8-zip \
	wget \
	unzip \
	&& rm -rf /var/cache/apk/*

# Create necessary directories for PHP-FPM and WordPress
RUN mkdir -p /run/php  /var/www/html /var/log/php && sleep 15

# Set working directory to /var/www before downloading WordPress
WORKDIR /var/www/html

# Download and install WordPress
RUN wget http://wordpress.org/latest.tar.gz && \
	tar xfz latest.tar.gz && \
	mv wordpress/* . && \
	rm -rf wordpress latest.tar.gz

# Copy custom PHP-FPM config and set proper permissions
COPY ./requirements/wordpress/conf/www.conf /etc/php8/php-fpm.d/www.conf

# Copy wp-config creation script
COPY ./requirements/wordpress/conf/wp-config-create.sh .

# Create wp-config.php and set correct permissions (to www-data)
RUN chmod +x wp-config-create.sh && \
	sh wp-config-create.sh && \
	rm wp-config-create.sh && \
	chmod -R 0777 wp-content

# Expose the PHP-FPM port (9000)
EXPOSE 9000

# Run PHP-FPM
CMD ["/usr/sbin/php-fpm8", "-F"]
