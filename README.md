# An Navicat running inside docker.

A Docker container for setting up Navicat. This is used as a utility container for connecting to AWS, cron and backup purposes. This container best suites development purposes.

This is a sample Navicat docker container used to test Wordpress installation on [http://www.globalfoodbook.com](http://www.globalfoodbook.com)


To build this navicat server run the following command:

```bash
$ docker pull globalfoodbook/navicat
```

This will doesn't expose any port.
To run the server on the host machine, run the following command:

```bash
$ docker run --name=navicat --env MARIADB_PORT=${MARIADB_PORT} --env MARIADB_USER=${MARIADB_USER} --env MARIADB_PASSWORD=${MARIADB_PASSWORD} --env MARIADB_DATABASE=${MARIADB_DATABASE} --env MARIADB_HOST=${MARIADB_HOST} --env GCS_AUTH=${GCS_AUTH} --env GCS_ACCESS_KEY=${GCS_ACCESS_KEY} --env GCS_SECRET_ACCESS_KEY=${GCS_SECRET_ACCESS_KEY} --detach --volume=/Users/ikennaokpala/repo/gfb/conductor/vagrant/scripts/dumps/:/dumps/ --cap-add mknod --cap-add sys_admin --device=/dev/fuse --privileged navicat
```

# NB:

## Before pushing to docker hub

## Login

```bash
$ docker login
```

## Build

```bash
$ cd /to/docker/directory/path/
$ docker build -t <username>/<repo>:latest .
```

## Push to docker hub

```bash
$ docker push <username>/<repo>:latest
```

IP=`docker inspect navicat | grep -w "IPAddress" | awk '{ print $2 }' | head -n 1 | cut -d "," -f1 | sed "s/\"//g"`
HOST_IP=`/sbin/ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`

DOCKER_HOST_IP=`awk 'NR==1 {print $1}' /etc/hosts` # from inside a docker container

# Contributors

* [Ikenna N. Okpala](http://ikennaokpala.com)
