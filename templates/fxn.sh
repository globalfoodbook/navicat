function mysqli () {
  /usr/bin/mysql -h$MARIADB_HOST -u$MARIADB_USER -p$MARIADB_PASSWORD -P$MARIADB_PORT $1
}

# function initiate_db () {
#   sql="$(cat /root/schema.sql)"
#   echo $(eval echo \"$sql\") > /root/.temp.sql
#   `mysqli < /root/.temp.sql`
#
#   rm /root/.temp.sql
# }

function restore_db () {
  `mysqli $MARIADB_DATABASE < $1`
}

function dump_db () {
  /usr/bin/mysqldump -h$MARIADB_HOST -u$MARIADB_USER -p$MARIADB_PASSWORD -P$MARIADB_PORT $MARIADB_DATABASE > $1
}

function mount_cloud_storage () {
  # Add -odefault_acl=public-read to GCS or S3 to allow public read
  if [[ $GCS_AUTH ]];
  then
    /usr/bin/s3fs $GCS_BUCKET $MOUNT -onomultipart -opasswd_file=$GCS_AUTH_FILE -osigv2 -ourl=https://storage.googleapis.com -ouse_path_request_style -ouse_cache=/tmp -ononempty
  elif [[ $AWS_S3 ]];
  then
    /usr/bin/s3fs $S3_BUCKET $MOUNT -ouse_cache=/tmp -ononempty
  fi
}
