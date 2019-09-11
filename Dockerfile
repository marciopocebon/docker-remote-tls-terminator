FROM haproxy:2.0.5-alpine

RUN apk add --no-cache \
  ca-certificates \
  gettext

COPY haproxy.cfg.template /usr/local/etc/haproxy/haproxy.cfg.template
COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["/usr/local/sbin/haproxy", "-f", "/usr/local/etc/haproxy/tmp/haproxy.cfg", "-db", "-W"]
ENTRYPOINT ["/docker-entrypoint.sh"]
