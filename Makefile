all: rmi build push

rmi:
	docker rmi bugcrowd/remote-tls-terminator || true

build:
	docker build -t bugcrowd/remote-tls-terminator:2.0.4 .

push:
	docker push bugcrowd/remote-tls-terminator:2.0.4
