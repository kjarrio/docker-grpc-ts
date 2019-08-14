# Docker Image
IMAGE_NAME ?= kjarrio/grpc-ts
TAG ?= latest

# Versions
NODE_VERSION ?= 8.16.0
GRPC_NODE_VERSION ?= 2.5.4
GRPC_NODE_TOOLS_VERSION ?= 1.22.2
PROTOC_GEN_TS_VERSION ?= 0.10.0

all: build

build:
	docker build \
	--build-arg NODE_VERSION=$(NODE_VERSION) \
	--build-arg GRPC_NODE_VERSION=$(GRPC_NODE_VERSION) \
	--build-arg GRPC_NODE_TOOLS_VERSION=$(GRPC_NODE_TOOLS_VERSION) \
	--build-arg PROTOC_GEN_TS_VERSION=$(PROTOC_GEN_TS_VERSION) \
	-t $(IMAGE_NAME):$(TAG) .

push: build
	docker push $(IMAGE_NAME):$(TAG)

clean:
	rm -rf build

.PHONY: all deps build push clean
