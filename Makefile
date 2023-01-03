build:
	docker build -t eugenmayer/unbound:1.17 . -f Dockerfile

pull:
	docker pull alpine:edge
	docker pull alpine:3.17

push:
	docker push eugenmayer/unbound:1.17

