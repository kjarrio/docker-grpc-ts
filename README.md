# Docker Image for TypeScript gRPC services
A lightweight `protoc` Docker image for generating gRPC services for Typescript.

## What's included:
- https://github.com/agreatfool/grpc_tools_node_protoc_ts
- https://github.com/grpc/grpc-node

## Usage

```bash
$ docker run --rm -v<some-path>:<some-path> -w<some-path> kjarrio/grpc-ts [OPTION] PROTO_FILES
```

For help try:
```bash
$ docker run --rm kjarrio/grpc-ts --help
```

### Inspired by:
- https://github.com/TheThingsIndustries/docker-protobuf