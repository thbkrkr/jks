FROM alpine:3.5

RUN apk --no-cache add bash
COPY docker-entrypoint.sh /docker-entrypoint.sh
ONBUILD COPY jobs /jobs

ENTRYPOINT ["/docker-entrypoint.sh"]
