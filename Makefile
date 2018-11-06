generate-dockerfiles:
	env DK_FROM_IMAGE='alpine:edge' gomplate -f Dockerfile.tpl -o Dockerfile_amd64
	env DK_FROM_IMAGE='arm32v6/alpine:edge' gomplate -f Dockerfile.tpl -o Dockerfile_arm32v6
	env DK_FROM_IMAGE='arm64v8/alpine:edge' gomplate -f Dockerfile.tpl -o Dockerfile_arm64v8

build: generate-dockerfiles
	docker build -t eugenmayer/unbound:1.8 . -f Dockerfile_amd64
	docker tag eugenmayer/unbound:1.8 eugenmayer/unbound:latest
	docker build -t eugenmayer/unbound:1.8-arm32v6 . -f Dockerfile_arm32v6
	docker tag eugenmayer/unbound:1.8-arm32v6 eugenmayer/unbound:1.8-arm32v7
	docker build -t eugenmayer/unbound:1.8-arm64v8 . -f Dockerfile_arm64v8

pull:
	docker pull alpine:edge
	docker pull arm32v7/alpine:edge
	docker pull arm64v8/alpine:edge

push:
	docker push eugenmayer/unbound:latest
	docker push eugenmayer/unbound:1.8
	docker push eugenmayer/unbound:1.8-arm32v6
	docker push eugenmayer/unbound:1.8-arm32v7
	docker push eugenmayer/unbound:1.8-arm64v8

init:
	go get github.com/hairyhenderson/gomplate/cmd/gomplate
