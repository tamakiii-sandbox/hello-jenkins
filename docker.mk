.PHONY: help build run bash

IMAGE := tamakiii-sandbox/hello-jenkins
CONTAINER ?= $(shell docker ps --quiet --filter ancestor=$(IMAGE))

PORT_HTTP := 8080
PORT_AGENT := 50000

help:
	@cat $(firstword $(MAKEFILE_LIST))

info:
	docker exec -it $(CONTAINER) cat /var/jenkins_home/secrets/initialAdminPassword

build: Dockerfile
	docker build -t $(IMAGE) .

run: build
	docker run \
		-p $(PORT_HTTP):8080 \
		-p $(PORT_AGENT):50000 \
		--restart=on-failure \
		-v $(PWD)/var/jenkins_home:/var/jenkins_home \
		$(IMAGE)

bash:
	docker run -it --rm $(IMAGE) $@
