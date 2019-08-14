# Basic Info
LABEL MAINTAINER="Kjartan Olason <olasonk@gmail.com>"

# Versions
ARG NODE_VERSION=8.16.0
ARG GRPC_NODE_VERSION=2.5.4
ARG GRPC_NODE_TOOLS_VERSION=1.22.2
ARG PROTOC_GEN_TS_VERSION=0.10.0

# Node docker
FROM node:${NODE_VERSION}-alpine

# Updates
RUN apk update && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

# Install some stuff
RUN apk add git --no-cache && \
    apk add su-exec --no-cache && \
    apk add sudo --no-cache && \
    apk add libc6-compat --no-cache && \

# Production Enviornment
ENV NODE_ENV production

# Install grpc_tools_node_protoc_ts globally
RUN npm i -g grpc_tools_node_protoc_ts@${PROTOC_GEN_TS_VERSION}

# Add node-grpc user to avoid being root
RUN useradd --home-dir /home/node-grpc/ --no-create-home node-grpc && \
    chown -R node-grpc:node-grpc /proto && \
    chown -R node-grpc:node-grpc /usr/src/node-grpc

USER node-grpc

# Home directory
WORKDIR /home/node-grpc/app/

# App folder
RUN mkdir -p /home/node-grpc/app/proto
RUN cd /home/node-grpc/app

# package.json
COPY package.json /home/node-grpc/app

# Install the node modules
RUN npm i -g grpc_tools_node_protoc_ts@${PROTOC_GEN_TS_VERSION} && \
    npm i grpc_tools_node_protoc_ts@${PROTOC_GEN_TS_VERSION} && \
    npm i grpc-tools@${GRPC_NODE_TOOLS_VERSION} && \
    npm i grpc@${GRPC_NODE_VERSION}

# Back to node user
USER node
ENV NODE_PATH=/home/node-grpc/node_modules:/data/node_modules

# Todo...
# To make TypeScript working, you need to replace the default node plugin with the ts version by adding the
# following option to you build: --plugin=protoc-gen-grpc=/usr/bin/protoc-gen-ts
# CMD ["npm", "start"]
# ENTRYPOINT ["protoc-wrapper", "-I/usr/include"]
