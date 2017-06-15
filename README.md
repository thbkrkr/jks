# Jenkins Docker image

Jenkins Docker image with [Docker](https://docs.docker.com)  based on
[jenkinsci/blueocean](https://hub.docker.com/r/_/jenkinsci/) and some groovy scripts in order to:
  - create an admin user
  - configure the number of executors
  - enable the slave master access control
  - setup an ssh key to clone private git repositories
  - create a seed job that uses the job dsl plugin to create all jobs
  - disable the jenkins cli over remoting
  - disable scripts security for the job dsl scripts

## Getting started

```shell
> cat jks.env
# Admin credentials
ADMIN_USERNAME=admin
ADMIN_PASSWORD=changeme

# Git repo url for the seed jobs (which uses the groovy job dsl plugin)
SEED_JOBS_URL=https://github.com/thbkrkr/ci

# '<name>:<key.pub.b64>' name and content in base 64 of the public ssh key to clone private repos
SEED_CREDS=ci-bitbucket.id_rsa:Ae7tL11CaUdJ...S0PLX

# Docker registry in base64 (base64 -w0 ~/.docker/config.json)
REGISTRY_AUTH=dezJI...Sn0c
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
