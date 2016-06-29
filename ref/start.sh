#!/bin/bash -eu

sed -i "s|{{ seed_job_image }}|$SEED_JOB_IMAGE|g" \
  /usr/share/jenkins/ref/jobs/zeed-jobs/config.xml

exec /bin/tini -- /usr/local/bin/jenkins.sh