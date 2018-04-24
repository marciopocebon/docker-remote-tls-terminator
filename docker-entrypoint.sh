#!/bin/sh

set -eo pipefail

if [[ ! "${REMOTE_PORT}" ]]; then
  export REMOTE_PORT="443"
fi

if [[ "${CERT_NAME}" ]]; then
  export HOST_VERIFICATION="verifyhost \"${CERT_NAME}\""
fi

if [[ ! "${CA_FILE}" ]]; then
  export CA_FILE="/etc/ssl/certs/ca-certificates.crt"
fi

if [[ ! "${SNI_HOSTNAME}" ]]; then
  export SNI_HOSTNAME="${REMOTE_HOST}"
fi

# Allow forced override of all haproxy backend settings
if [[ ! "${HAPROXY_BACKED_OPTIONS}" ]]; then
  export HAPROXY_BACKED_OPTIONS="\"${REMOTE_HOST}:${REMOTE_PORT}\" ssl sni str(${SNI_HOSTNAME}) verify required ${HOST_VERIFICATION} ca-file \"${CA_FILE}\" no-sslv3 no-tlsv10"
fi

mkdir -p /usr/local/etc/haproxy/tmp
cat /usr/local/etc/haproxy/haproxy.cfg.template | envsubst > /usr/local/etc/haproxy/tmp/haproxy.cfg

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
