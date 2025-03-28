FROM alpine:3.21

RUN apk update && apk upgrade && apk add --no-cache nginx openssl

COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]
