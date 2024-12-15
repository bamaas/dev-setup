FROM ubuntu:22.04
USER root
WORKDIR setup
COPY ./src .
RUN DOCKER_BUILD=true \
    ./install.sh
WORKDIR /src
RUN cp /root/.zshrc /root/.zshenv
SHELL ["/bin/zsh", "-c"]
ENTRYPOINT ["/bin/zsh", "-c"]
CMD ["zsh"]