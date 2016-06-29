# Jenkins Docker image

Jenkins Docker image with [Docker](https://docs.docker.com), [Docker Machine](https://docs.docker.com/machine/),
[Docker Compose](https://docs.docker.com/compose/) based on
[jenkins:alpine](https://hub.docker.com/r/_/jenkins/).

With:

  - Custom admin login/password
  - A seed job using the Job DSL plugin
  - HipChat notifications
  - SSH key to clone git repositories

# Getting started

## Start Jenkins

```
> cat docker-compose.yml
version: '2'
services:
  jks:
    container_name: jenkins
    image: krkr/jks
    env_file:
      - ./jks.env
    ports:
      - 8080:8080
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /usr/bin/docker:/usr/bin/docker
      - ./var_jenkins:/var/jenkins
```

```
> cat jks.env
# Admin credentials
ADMIN_USERNAME=nimda
ADMIN_PASSWORD=adm!n
# HipChat notifications
HIPCHAT_TOKEN=1234567890azertyuiop0987654321
# Public SSH key to clone git repositories
SEED_CREDS_ID=ssh_creds_id
```

```
docker-compose up -d
```

## Write jobs using the Job DSL

```
> cat jobs/c0a1-dm-ls.groovy
job('c0a1-dm-ls') {
  steps {
    shell('docker run c0/a1 docker-machine ls')
  }
}

> cat Dockerfile
FROM krkr/jks-jobs

> docker build -t jks/jobs .
```