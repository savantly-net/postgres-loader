#!/bin/bash

# Required env vars

## Set Your AWS Access credentials
# AWS_ACCESS_KEY
# AWS_SECRET_ACCESS_KEY

## Replace with your s3 bucket name
# S3_BUCKET_NAME

echo $AWS_ACCESS_KEY:$AWS_SECRET_ACCESS_KEY > /root/.passwd-s3fs && \
  chmod 600 /root/.passwd-s3fs

s3fs $S3_BUCKET_NAME $S3_MOUNT_DIRECTORY

# turn on bash's job control
set -m

# extract environment variables for cron
printenv | sed 's/^\(.*\)$/export \1/g' > /root/project_env.sh

# Start the helper processes
service rsyslog start

chmod -R 0644 /crontab
crontab /crontab

bash