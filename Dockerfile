FROM ubuntu

RUN echo "deb http://archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install dialog net-tools lynx nano wget
RUN apt-get -y install python-software-properties
RUN add-apt-repository -y ppa:nginx/stable
RUN add-apt-repository -y ppa:ondrej/php5-oldstable
RUN apt-get update

RUN apt-get -y install nginx php5-fpm php5-mysql

RUN wget -O /etc/nginx/sites-available/default https://gist.github.com/darron/6159214/raw/30a60885df6f677bfe6f2ff46078629a8913d0bc/gistfile1.txt
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini
RUN mkdir /var/www
RUN echo "<?php phpinfo(); ?>" > /var/www/index.php

RUN service php5-fpm start
RUN service nginx restart
