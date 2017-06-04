FROM jenkinsci/blueocean:1.0.1

USER root

# Plugins
RUN /usr/local/bin/install-plugins.sh \
    workflow-aggregator:2.5 \
    workflow-multibranch:2.14 \
    pipeline-stage-view:2.6 \
    pipeline-utility-steps:1.3.0 \
    pipeline-model-definition:1.1.2 \
    github-branch-source:2.0.5 \
    github-organization-folder:1.6 \
    ssh-agent:1.15 \
    mailer:1.20 \
    buildtriggerbadge:2.8.1 \
    hipchat:2.1.1 \
    job-dsl:1.60

# Install jq, make, docker and doo
RUN apk --no-cache add jq make && \
    \
    curl -sL https://get.docker.com/builds/Linux/x86_64/docker-17.05.0-ce.tgz | tar zx && \
        mv /docker/* /bin/ && chmod +x /bin/docker* && \
    \
    curl -s https://raw.githubusercontent.com/thbkrkr/doo/f8e46fb120e174b0f94fd578cbafd44a6612e3fa/doo \
        > /usr/local/bin/doo && chmod +x /usr/local/bin/doo

# Init groovy scripts
COPY init.groovy.d /usr/share/jenkins/ref/init.groovy.d

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]