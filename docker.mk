.PHONY: help build bash clean

IMAGE := tamakiii-sandbox/hello-jenkins

help:
	@cat $(firstword $(MAKEFILE_LIST))

build: Dockerfile
	docker build -t $(IMAGE) .

bash: build
	docker run --rm -it -v $(shell pwd):/work -w /work $(IMAGE) $@

clean:
	docker image rm $(IMAGE)
