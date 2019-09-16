all: rmi build push

rmi:
	docker rmi bugcrowd/remote-tls-terminator || true

build:
	docker build -t bugcrowd/remote-tls-terminator:1.0.0 .

push:
	docker push bugcrowd/remote-tls-terminator:1.0.0

production: 
	docker push bugcrowd/remote-tls-terminator:latest
