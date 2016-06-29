#!/bin/bash -eu

case $1 in
  ls)
    ls -1 /jobs/*.groovy
    ;;
  get)
    cat /jobs/$2
    ;;
  sh)
    echo '
      rm -rf jobs
      mkdir jobs
      for j in $(docker run --rm '$SEED_JOBS_IMAGE' ls | sed "s|/jobs/||"); do
        docker run --rm '$SEED_JOBS_IMAGE' get $j > jobs/$j
      done
    '
    ;;
  *)
    exec $@
    ;;
esac
