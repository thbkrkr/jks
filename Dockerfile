FROM jenkinsci/jenkins:2.81-alpine

USER root

# Plugins
RUN /usr/local/bin/install-plugins.sh \
    workflow-aggregator:2.5 \
    workflow-multibranch:2.16 \
    pipeline-model-definition:1.1.9 \
    pipeline-stage-view:2.9 \
    pipeline-utility-steps:1.4.0 \
    github-branch-source:2.2.3 \
    github-organization-folder:1.6 \
    blueocean:1.2.0 \
    ssh-agent:1.15 \
    mailer:1.20 \
    buildtriggerbadge:2.8.1 \
    hipchat:2.1.1 \
    job-dsl:1.65 \
    bitbucket:1.1.5

# Install jq, make, docker, docker-compose and doo
RUN apk --no-cache add jq make && \
    \
    curl -sL https://download.docker.com/linux/static/stable/x86_64/docker-17.09.0-ce.tgz | tar zx && \
        mv /docker/* /bin/ && chmod +x /bin/docker* && \
    \
    apk add --no-cache py2-pip && \
    pip install --upgrade pip && \
    pip install docker-compose==1.16.1 && \
    \
    curl -sSL https://raw.githubusercontent.com/thbkrkr/doo/b3a90ab3ba1b3375e9a9a2ec20da868473971205/doo \
        > /usr/local/bin/doo && chmod +x /usr/local/bin/doo && \
    \
    curl -sSL https://github.com/thbkrkr/qli/releases/download/0.2.3/oq \
        > /usr/local/bin/oq && chmod +x /usr/local/bin/oq

# Init groovy scripts
COPY init.groovy.d /usr/share/jenkins/ref/init.groovy.d

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]