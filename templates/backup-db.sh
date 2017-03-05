#!/bin/bash
# export MARIADB_PORT=`awk 'NR==1 {print $1}' /etc/hosts`

# set -e
# set -x #use then debuging
source /usr/bin/fxn.sh
source /root/.env

if [ ! -d "$BACKUP" ]; then
  /bin/mkdir -p $BACKUP
fi

if [[ $GCS_AUTH || $AWS_S3 ]];
then
  NOW=$(date +"%Y-%m-%d-%H%M")
  DB_FILE="$MARIADB_DATABASE.$NOW.sql"

  mount_cloud_storage
  dump_db "$BACKUP/$DB_FILE"

  /bin/tar -czvf $BACKUP/"$DB_FILE.tar.gz" -P $BACKUP/$DB_FILE

  /bin/cp $BACKUP/"$DB_FILE.tar.gz" $MOUNT/data/
  /bin/rm $BACKUP/"$DB_FILE.tar.gz" $BACKUP/"$DB_FILE"
fi
