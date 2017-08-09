all: rmi build push

rmi:
	docker rmi bugcrowd/remote-tls-terminator || true

build:
	docker build -t bugcrowd/remote-tls-terminator .

push:
	docker push bugcrowd/remote-tls-terminator
