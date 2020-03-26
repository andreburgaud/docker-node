TAG:=13.10.1
IMAGE:=andreburgaud/node

default: help

build:
	@docker build -t ${IMAGE} .

clean:
	# Remove containers with exited status:
	@docker rm `docker ps -a -f status=exited -q` || true
	@docker rmi ${IMAGE}:latest || true
	@docker rmi ${IMAGE}:${TAG} || true
	# Delete dangling images
	@docker rmi `docker images -f dangling=true -q` || true

help:
	@echo 'Node ${TAG} Docker image build file'
	@echo
	@echo 'Usage:'
	@echo '    make build           Build the image using local Dockerfile'
	@echo '    make clean           Delete dangling Docker images'
	@echo '    make run             Start docker container'
	@echo '    make tag             Push code to repo and apply tag'
	@echo

run:
	@docker run --rm -it ${IMAGE}

tag:
	@git push
	@git tag -a ${TAG} -m 'Version ${TAG}'
	@git push origin --tags

.PHONY: build clean help run tag
