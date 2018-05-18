#!/bin/sh
# `/sbin/setuser memcache` runs the given command as the user `memcache`.
# If you omit that part, the command will be run as root.
cd /home/app/systems/api
export REDIS_HOST=redis
export REDIS_DATABASE=2
export AWS_ACCESS_KEY_ID=accessKey1
export AWS_SECRET_ACCESS_KEY=verySecretKey1
export S3_UPLOAD_BUCKET=etapibucket
export AWS_REGION=us-east-1
export AWS_ENDPOINT=http://s3.et:3200
export AWS_S3_FORCE_PATH_STYLE=true
export SMTP_HOSTNAME=smtp
export SMTP_PORT=1025

exec /sbin/setuser app bundle exec sidekiq >>/home/app/systems/api/log/nginx_sidekiq.log 2>&1
