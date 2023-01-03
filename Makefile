build: pull
	docker build -t ghcr.io/eugenmayer/unbound:1.17 . -f Dockerfile

pull:
	docker pull alpine:edge
	docker pull alpine:3.17

push:
	docker push ghcr.io/eugenmayer/unbound:1.17

