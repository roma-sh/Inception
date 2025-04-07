#!/bin/sh

cat << EOF > /var/www/html/wp-config.php
<?php
define( 'DB_NAME', '${DB_NAME}' );
define( 'DB_USER', '${DB_USER}' );
define( 'DB_PASSWORD', '${DB_PASS}' );
define( 'DB_HOST', '${DB_HOST}' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define('FS_METHOD','direct');
\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );

// Custom added values
define( 'WP_URL', '${WP_URL}' );
define( 'WP_TITLE', '${WP_TITLE}' );
define( 'WP_ADMIN_USER', '${WP_ADMIN_USER}' );
define( 'WP_ADMIN_PASSWORD', '${WP_ADMIN_PASSWORD}' );
define( 'WP_ADMIN_EMAIL', '${WP_ADMIN_EMAIL}' );
define( 'WP_USER', '${WP_USER}' );
define( 'WP_USER_EMAIL', '${WP_USER_EMAIL}' );
define( 'WP_PASS', '${WP_USER_PASSWORD}' );

if ( ! defined( 'ABSPATH' ) )
{
	define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';
EOF

# Wait for a while to ensure the config file is written before continuing
sleep 5

# Install WordPress manually by copying WordPress files if not already installed
if [ ! -d "/var/www/html/wp-content" ]; then
	echo "WordPress directory not found. Please ensure WordPress is properly copied to /var/www/html."
	exit 1
fi

# Optionally, create admin user in the database
echo "You may want to run wp core install and wp user create commands manually."
