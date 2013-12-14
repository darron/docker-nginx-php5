docker-nginx-php5
=================

DEPRECATED - all new development is taking place on [octohost](https://github.com/octohost/php5-nginx)

A Dockerfile to create a Docker image with nginx and php5-fpm

This was created using [this blog post](http://hotcashew.com/2013/07/lemp-stack-in-a-docker-io-container/) and lots of Googling.

It's posted on the Docker INDEX at [darron/nginx](https://index.docker.io/u/darron/nginx/)

To build:

```
git clone https://github.com/darron/docker-nginx-php5.git
cd docker-nginx-php5
docker build -t <yournamehere>/nginx .
```

You can then run the built image: `docker run -d <yournamehere>/nginx`

You should see a running image if you run docker ps

```
vagrant@ubuntu-13:~$ docker run -d darron/nginx
6592bc4c0193
vagrant@ubuntu-13:~$ docker ps
ID                  IMAGE                 COMMAND                CREATED             STATUS              PORTS
6592bc4c0193        darron/nginx:latest   /bin/sh -c service p   2 seconds ago       Up 1 seconds        49153->80
```

To serve another site - you can layer on top of this - here's an example Dockerfile:

```
FROM darron/nginx

# Build your new site here. 
RUN echo "Site 123 ABC" > /var/www/index.php
RUN echo "<?php phpinfo(); ?>" >> /var/www/index.php
 
EXPOSE 80
 
CMD service php5-fpm start && nginx
```

