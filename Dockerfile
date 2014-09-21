FROM ishakuta/ubuntu
MAINTAINER Ivan Shakuta "ishakuta@gmail.com"

RUN DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:nginx/stable && \
	DEBIAN_FRONTEND=noninteractive apt-get -qy update && \
	DEBIAN_FRONTEND=noninteractive apt-get -qy install nginx \
	php5-fpm php5-mysql php5-gd php5-intl php5-imagick php5-mcrypt \
	php5-curl php5-cli php5-xdebug

ADD default-site /etc/nginx/sites-available/default

# install composer and phpunit
RUN curl -sS https://getcomposer.org/installer | php && \
	mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer && \
	composer global require 'phpunit/phpunit=3.7.*' && \
	echo "export PATH=$PATH:/.composer/vendor/bin/:" >> /root/.profile && \
    echo "export PATH=$PATH:/.composer/vendor/bin/:" >> /home/ubuntu/.profile

# configure nginx, fpm and start services
RUN echo "daemon off;" >> /etc/nginx/nginx.conf && \
    echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini && \
    mkdir /var/www && echo "<?php phpinfo(); ?>" > /var/www/index.php

# add daemons
RUN echo '[program:php5-fpm]' > /usr/local/etc/supervisor.d/php5-fpm.conf && \
    echo 'command=service php5-fpm start' >> /usr/local/etc/supervisor.d/php5-fpm.conf && \
    echo '[program:nginx]' > /usr/local/etc/supervisor.d/nginx.conf && \
    echo 'command=/usr/sbin/nginx' >> /usr/local/etc/supervisor.d/nginx.conf

EXPOSE 80
