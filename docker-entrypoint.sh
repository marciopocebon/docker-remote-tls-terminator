#!/bin/sh

set -eo pipefail

if [[ ! "${REMOTE_PORT}" ]]; then
  export REMOTE_PORT="443"
fi

if [[ ! "${CERT_NAME}" ]]; then
  export CERT_NAME="${REMOTE_HOST}"
fi

if [[ ! "${CA_FILE}" ]]; then
  export CA_FILE="/etc/ssl/certs/ca-certificates.crt"
fi

cat /usr/local/etc/haproxy/haproxy.cfg.template | envsubst > /usr/local/etc/haproxy/haproxy.cfg

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- haproxy "$@"
fi

if [ "$1" = 'haproxy' ]; then
	# if the user wants "haproxy", let's use "haproxy-systemd-wrapper" instead so we can have proper reloadability implemented by upstream
	shift # "haproxy"
  /sbin/syslogd -O /proc/1/fd/1
	set -- "$(which haproxy-systemd-wrapper)" -p /run/haproxy.pid "$@"
fi

exec "$@"
