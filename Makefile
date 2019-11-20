TAG:=13.1.0
IMAGE:=andreburgaud/node

default: help

help:
	@echo 'Node ${TAG} Docker image build file'
	@echo
	@echo 'Usage:'
	@echo '    make clean           Delete dangling Docker images'
	@echo '    make build           Build the image using local Dockerfile'
	@echo '    make push            Push an existing image to Docker Hub'
	@echo

build:
	@docker build -t ${IMAGE} .

clean:
	# Remove containers with exited status:
	@docker rm `docker ps -a -f status=exited -q` || true
	@docker rmi ${IMAGE}:latest || true
	@docker rmi ${IMAGE}:${TAG} || true
	# Delete dangling images
	@docker rmi `docker images -f dangling=true -q` || true

run:
	@docker run --rm -it ${IMAGE}

github:
	@git push
	@git tag -a ${TAG} -m 'Version ${TAG}'
	@git push origin --tags

.PHONY: help build clean run github
