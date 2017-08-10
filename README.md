Remote TLS Terminator
======================

A simple HAProxy configuration designed to terminate a TLS connection to a remote server with certificate verification. Useful when you need to connect to a TLS backend but your tool or service doesn't support TLS.

Usage
-----

```
docker run --rm -it \
  -e REMOTE_HOST=google.com \
  -e CERT_NAME=*.google.com \
  -p 8000:80 \
  bugcrowd/remote-tls-terminator
```

Options
-------

*   REMOTE_HOST = The remote host you wish to connect to
*   REMOTE_PORT = The port on the remote host you wish to connect to. Defaults to 443
*   CERT_NAME = The name on the certificate to verify the host against. If no certificate name is provide no host verification is performed
*   CA_FILE = A list of Certificate Authorities to verify the certificate against. Defaults to system CA's
