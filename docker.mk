.PHONY: help build run bash

IMAGE := tamakiii-sandbox/hello-jenkins
CONTAINER ?= $(shell docker ps --quiet --filter ancestor=$(IMAGE))

help:
	@cat $(firstword $(MAKEFILE_LIST))

info:
	docker exec -it  $(CONTAINER) cat /var/jenkins_home/secrets/initialAdminPassword

build: Dockerfile
	docker build -t $(IMAGE) .

run: build
	docker run -p 8080:8080 -p 50000:50000 --restart=on-failure -v jenkins_home:/var/jenkins_home $(IMAGE)

bash:
	docker run -it --rm $(IMAGE) $@
