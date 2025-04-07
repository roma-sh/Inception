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
