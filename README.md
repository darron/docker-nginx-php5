docker-nginx-php5
=================

A Dockerfile to create a Docker image with nginx and php5-fpm

This was created using [this blog post](http://hotcashew.com/2013/07/lemp-stack-in-a-docker-io-container/) and lots of Googling.

It's posted on the Docker INDEX at [ishakuta/docker-nginx-php5](https://index.docker.io/u/ishakuta/docker-nginx-php5/)

To build:

```
git clone https://github.com/ishakuta/docker-nginx-php5.git
cd docker-nginx-php5
docker build -t <yournamehere>/nginx .
```

You can then run the built image: `docker run -d <yournamehere>/nginx-php5-fpm`

You should see a running image if you run docker ps

```
vagrant@ubuntu-13:~$ docker run -d <yournamehere>/nginx-php5-fpm
6592bc4c0193
vagrant@ubuntu-13:~$ docker ps
ID                  IMAGE                 COMMAND                CREATED             STATUS              PORTS
6592bc4c0193        <yournamehere>/docker-nginx-php5:latest   /bin/sh -c service p   2 seconds ago       Up 1 seconds        49153->80
```

To serve another site - you can layer on top of this - here's an example Dockerfile:

```
FROM ishakuta/docker-nginx-php5

# Build your new site here. 
RUN echo "Site 123 ABC" > /var/www/index.php
RUN echo "<?php phpinfo(); ?>" >> /var/www/index.php
 
EXPOSE 80
 
CMD service php5-fpm start && nginx
```

