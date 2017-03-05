#!/bin/bash
# export MARIADB_HOST_IP=`awk 'NR==1 {print $1}' /etc/hosts`

# set -e
source /usr/bin/fxn.sh
# set -x #use then debuging

if [[ ! -d $MOUNT ]]; then
  mkdir -p $MOUNT
fi

NOW=$(date +"%Y-%m-%d-%H%M")
env > /root/.env.temp
egrep -v " +" .env.temp > .env

if [[ $AWS_S3 ]]; then
  if [[ ! -f ~/.passwd-s3fs || ! -f /etc/passwd-s3fs ]]; then
    echo $AWS_S3 >> ~/.passwd-s3fs && cp ~/.passwd-s3fs /etc/passwd-s3fs

    chmod 600 ~/.passwd-s3fs
    chmod 640 /etc/passwd-s3fs
  fi
elif [[ $GCS_AUTH ]]; then
  if [[ ! -f $GCS_AUTH_FILE ]]; then
    # echo $GCS_AUTH >> ~/.gcs-auth.txt && cp ~/.gcs-auth.txt $GCS_AUTH_FILE
    echo $GCS_AUTH >> $GCS_AUTH_FILE

    chmod 600 $GCS_AUTH_FILE
  fi
fi

if [[ $MARIADB_HOST ]]; then
  counter=0;
  while ! nc -vz $MARIADB_HOST $MARIADB_PORT; do
    counter=$((counter+1));
    if [ $counter -eq 6 ]; then break; fi;
    sleep 10;
  done
fi

sudo rsyslogd
sudo tail -F /var/log/syslog
