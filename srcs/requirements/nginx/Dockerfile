FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	nginx \
	openssl \
	&& rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/ssl && \
	openssl req -x509 -nodes -days 365 -newkey rsa:4096 -sha256 \
	-keyout /etc/nginx/ssl/rshatra.42.fr.key \
	-out /etc/nginx/ssl/rshatra.42.fr.crt \
	-subj "/C=MY/ST=EARTH/L=SOMEWHERE/O=42/OU=WHAT/CN=rshatra.42.fr"

CMD ["nginx", "-g", "daemon off;"]


# openssl req: a certificate request process
# -x509: generating a self-signed X.509 certificate, which is commonly used for SSL/TLS
# -nodes: (no DES) no encryption for the private key, not recommended in production!
# -days 365: validity period of the certificate
# -newkey rsa:4096: a new RSA key pair with a key size of 4096 bits. RSA is a common
	# algorithm used for creating public/private key pairs
# -sha256: SHA-256 hashing algorithm will be used to sign the certificate.
	# SHA-256 is a secure hashing algorithm widely used in certificates.
