# Jenkins Docker image

Jenkins Docker image with [Docker](https://docs.docker.com)  based on
[jenkinsci/blueocean](https://hub.docker.com/r/_/jenkinsci/) and some groovy scripts in order to:
  - create an admin user
  - configure the number of executors
  - enable the slave master access control
  - setup an SSH key to clone private git repositories
  - create a seed job that uses the Job DSL plugin

## Getting started

```shell
> cat jks.env
# Admin credentials
ADMIN_USERNAME=admin
ADMIN_PASSWORD=changeme
# Git repository url of the seed jobs
SEED_JOBS_URL=https://github.com/<you>/ci
# Public SSH key to clone git repositories
SEED_CREDS_ID=ssh_creds_id
```

```yaml
> cat docker-compose.yml
version: '2'
services:
  jks:
    image: krkr/jks
    env_file:
      - ./jks.env
    ports:
      - 8080:8080
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./data/var_jenkins_home:/var/jenkins_home
```

```
docker-compose up -d
```
