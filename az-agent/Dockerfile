ARG BASE_TAG=latest

FROM bamaas/devcontainer:${BASE_TAG}
ENV TARGETARCH="linux-x64"

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    software-properties-common \
    gnupg \
    apt-transport-https \
    ca-certificates \
    sudo \
    git \
    libicu70 \
    jq  \
    ssh \
    && rm -rf /var/lib/apt/lists/*

## Install azure devops agent
WORKDIR /azp/

COPY ./start.sh ./
RUN chmod +x ./start.sh

# Create agent user and set up home directory
RUN useradd -m -d /home/agent agent
RUN chown -R agent:agent /azp /home/agent
USER agent

# Another option is to run the agent as root.
ENV AGENT_ALLOW_RUNASROOT="true"
USER root

ENTRYPOINT [ "./start.sh" ]
