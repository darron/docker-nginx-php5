FROM stackbrew/ubuntu:quantal
MAINTAINER Ivan Shakuta "ishakuta@gmail.com"

# TODO: add gpg key here instead of add-apt-repository (that needs python, etc)

RUN apt-get -qy update && locale-gen en_US.UTF-8
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install nano wget curl software-properties-common
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:nginx/stable
RUN apt-get -qy update

# install nginx and php5
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install nginx php5-fpm php5-mysql php5-gd php5-intl php5-imagick php5-mcrypt php5-curl php5-cli php5-xdebug openssh-server git
RUN wget -O /etc/nginx/sites-available/default https://raw.github.com/ishakuta/docker-nginx-php5/master/default-site

# install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

# install phpunit
RUN composer global require 'phpunit/phpunit=3.7.*' && \
    echo "export PATH=$PATH:/.composer/vendor/bin/:" >> /root/.profile

RUN echo "daemon off;" >> /etc/nginx/nginx.conf && \
    echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini

RUN mkdir /var/www && echo "<?php phpinfo(); ?>" > /var/www/index.php

RUN mkdir /var/run/sshd && \
    echo "#!/bin/bash" >> /run.sh && \
    echo "service php5-fpm start" >> /run.sh && \
    echo "/usr/sbin/sshd" >> /run.sh && \
    echo "/usr/sbin/nginx" >> /run.sh && chmod +x /run.sh

RUN echo root:root | chpasswd && \
    useradd u -s /bin/bash -m -p `perl -e 'print crypt("u", "salt"),"\n"'` && \
    echo 'u	ALL=(ALL:ALL) ALL' >> /etc/sudoers && \
    echo "export PATH=$PATH:/.composer/vendor/bin/:" >> /home/u/.profile

EXPOSE 80
ENTRYPOINT ["/run.sh"]

