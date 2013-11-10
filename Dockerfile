FROM ubuntu:quantal
MAINTAINER Ivan Shakuta "ishakuta@gmail.com"

#RUN echo "deb http://archive.ubuntu.com/ubuntu/ raring universe" >> /etc/apt/sources.list
#RUN "deb http://ppa.launchpad.net/nginx/stable/ubuntu quantal main" >> /etc/apt/sources.list
#RUN "deb-src http://ppa.launchpad.net/nginx/stable/ubuntu quantal main" >> /etc/apt/sources.list
# TODO: add gpg key here instead of add-apt-repository (that needs python, etc)

RUN DEBIAN_FRONTEND=noninteractive apt-get -qy update
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install nano wget curl mlocate software-properties-common

# install nginx and php5
RUN add-apt-repository -y ppa:nginx/stable && apt-get -qy update && apt-get -qy install nginx php5-fpm php5-mysql php5-imagick php5-mcrypt php5-curl
RUN wget -O /etc/nginx/sites-available/default https://raw.github.com/ishakuta/docker-nginx-php5/master/default-site

#RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini

RUN mkdir /var/www && echo "<?php phpinfo(); ?>" > /var/www/index.php

EXPOSE 80
CMD service php5-fpm start && nginx

