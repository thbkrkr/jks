FROM jenkins:alpine

USER root

# Install Docker, Docker Compose and Docker Machine
ENV DOCKER_VERSION=1.11.1 \
    DOCKER_COMPOSE_VERSION=1.7.1 \
    DOCKER_MACHINE_VERSION=0.7.0
RUN apk --update \
        add curl && \
        curl https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz | tar zx && \
        mv /docker/* /bin/ && chmod +x /bin/docker* \
    && \
        apk add py-pip && \
        pip install docker-compose==${DOCKER_COMPOSE_VERSION} \
    && \
        curl -sL https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION}/docker-machine-Linux-x86_64 > /usr/local/bin/docker-machine && \
        chmod +x /usr/local/bin/docker-machine

# Install plugins
COPY plugins/plugins.txt /plugins.txt
RUN /usr/local/bin/plugins.sh /plugins.txt

# Copy groovy scripts and seed jobs
COPY ref /usr/share/jenkins/ref
