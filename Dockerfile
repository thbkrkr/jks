FROM jenkins/jenkins:2.102-alpine

USER root

# Plugins
RUN /usr/local/bin/install-plugins.sh \
    workflow-aggregator:2.5 \
    workflow-multibranch:2.16 \
    pipeline-model-definition:1.2.5 \
    pipeline-stage-view:2.9 \
    pipeline-utility-steps:1.5.1 \
    github-branch-source:2.3.2 \
    github-organization-folder:1.6 \
    blueocean:1.3.5 \
    ssh-agent:1.15 \
    mailer:1.20 \
    buildtriggerbadge:2.9 \
    hipchat:2.1.1 \
    job-dsl:1.66 \
    bitbucket:1.1.8

# Install jq, make, docker, docker-compose and doo
RUN apk --no-cache add jq make && \
    \
    curl -sL https://download.docker.com/linux/static/edge/x86_64/docker-17.11.0-ce.tgz | tar zx && \
        mv /docker/* /bin/ && chmod +x /bin/docker* && \
    \
    apk add --no-cache py2-pip && \
    pip install --upgrade pip && \
    pip install docker-compose==1.18.0 && \
    \
    curl -sSL https://raw.githubusercontent.com/thbkrkr/doo/7911779151a06d1e7172f0f18effe2ca2435d32a/doo \
        > /usr/local/bin/doo && chmod +x /usr/local/bin/doo

# Init groovy scripts
COPY init.groovy.d /usr/share/jenkins/ref/init.groovy.d

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]