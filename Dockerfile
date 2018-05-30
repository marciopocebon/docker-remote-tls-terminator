FROM haproxy:1.7.8-alpine

RUN apk add --no-cache \
  ca-certificates \
  gettext \
  tini

COPY haproxy.cfg.template /usr/local/etc/haproxy/haproxy.cfg.template
COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["haproxy", "-f", "/usr/local/etc/haproxy/tmp/haproxy.cfg", "-d"]
ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]
