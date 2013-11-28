FROM stackbrew/ubuntu:quantal
MAINTAINER Ivan Shakuta "ishakuta@gmail.com"

# TODO: add gpg key here instead of add-apt-repository (that needs python, etc)

RUN apt-get -qy update
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install nano wget curl software-properties-common
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:nginx/stable
RUN apt-get -qy update

# install nginx and php5
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install nginx php5-fpm php5-mysql php5-gd php5-intl php5-imagick php5-mcrypt php5-curl php5-cli openssh-server git
RUN wget -O /etc/nginx/sites-available/default https://raw.github.com/ishakuta/docker-nginx-php5/master/default-site

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini

RUN mkdir /var/www && echo "<?php phpinfo(); ?>" > /var/www/index.php

RUN mkdir /var/run/sshd
RUN echo "#!/bin/bash" >> /run.sh && \
    echo "service php5-fpm start" >> /run.sh && \
    echo "/usr/sbin/sshd" >> /run.sh && \
    echo "/usr/sbin/nginx" >> /run.sh && chmod +x /run.sh

RUN echo root:root | chpasswd

EXPOSE 80
ENTRYPOINT ["/run.sh"]

