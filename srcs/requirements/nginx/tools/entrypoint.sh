#!/bin/sh

SSL_CERT="/etc/nginx/ssl/rshatra.42.fr.crt"
SSL_KEY="/etc/nginx/ssl/rshatra.42.fr.key"

mkdir -p /etc/nginx/ssl

# Check if certificates already exist
if [ ! -f "$SSL_CERT" ] || [ ! -f "$SSL_KEY" ]; then
	echo "Generating self-signed SSL certificates..."
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout "$SSL_KEY" -out "$SSL_CERT" \
		-subj "/C=US/ST=Local/L=Local/O=Local/CN=rshatra.42.fr"
	chmod 644 /etc/nginx/ssl/rshatra.42.fr.crt
	chmod 644 /etc/nginx/ssl/rshatra.42.fr.key

else
	echo "SSL certificates already exist. Skipping generation."
fi

# Start Nginx
nginx -g "daemon off;"


# -f: Check if a file exists.

# -p: Create directories only if they don't exist (mkdir won't throw an error if already exist).

# req: Specifies the "certificate request" functionality

# -x509: Tells openssl to generate a self-signed certificate (instead of creating a certificate
# request that would need to be signed by a Certificate Authority).

# -nodes:  No DES encryption. This means the private key won't be encrypted with a passphrase,
# which makes it easier for Nginx to use automatically.

# -days 365: Validity of the certificate (1 year).

# -newkey rsa:2048: Create a new RSA key pair with 2048 bits.

# -keyout: Specify where to save the private key.

# -out: Specify where to save the certificate.

# -subj: Sets the subject of the certificate,
# which contains the identity of the entity the certificate is for:

# C=US: Country (US).

# ST=Local: State (Local).

# L=Local: Locality (Local).

# O=Local: Organization (Local).

# CN=localhost: Common Name (localhost, which typically represents the server's domain name).

# -g "daemon off;": Runs Nginx in the foreground (daemon off), which is necessary
# for running Nginx in a Docker container. Otherwise, it would start in the background
# and the container would immediately stop.


