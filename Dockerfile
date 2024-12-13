FROM ubuntu:22.04
WORKDIR setup
COPY ./src .
RUN DOCKER_BUILD=true \
    ./install.sh
WORKDIR /src
