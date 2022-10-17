IMAGE_NAME = cgroupsv2-demo
REPO_NAME = jallphin/$(IMAGE_NAME)
REGISTRY = docker.io
VERSION = v0.0.1

.PHONY: build test run image-build image-push VERSION
default: build
build:
	go build .
run: build
	./cgroupsv2-demo
image:
	DOCKER_BUILDKIT=1 docker build -t $(IMAGE_NAME):latest .
image-run: image
	docker run --rm -it $(IMAGE_NAME):latest
image-build: image
	docker tag $(IMAGE_NAME):latest $(IMAGE_NAME):$(VERSION)
	docker tag $(IMAGE_NAME):latest $(REGISTRY)/$(REPO_NAME):$(VERSION)
image-push: image-build
	docker push $(REGISTRY)/$(REPO_NAME):$(VERSION)