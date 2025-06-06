FROM ubuntu:22.04
ARG PLAYBOOK
USER root
WORKDIR /setup
COPY ./src .
RUN DOCKER_BUILD=true \
    ./install.sh ${PLAYBOOK}
RUN rm -rf /setup
WORKDIR /src
RUN cp /root/.zshrc /root/.zshenv
SHELL ["/bin/zsh", "-c"]
ENTRYPOINT ["/bin/zsh", "-c"]
CMD ["zsh"]