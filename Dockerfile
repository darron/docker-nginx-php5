FROM base

MAINTAINER Ivan Shakuta "ishakuta@gmail.com"

#RUN echo "deb http://archive.ubuntu.com/ubuntu/ raring universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install nano wget curl
RUN apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:nginx/stable
#RUN add-apt-repository -y ppa:ondrej/php5-oldstable
RUN apt-get update

RUN apt-get -y install nginx php5-fpm php5-mysql php5-imagick php5-mcrypt

RUN wget -O /etc/nginx/sites-available/default https://gist.github.com/darron/6159214/raw/30a60885df6f677bfe6f2ff46078629a8913d0bc/gistfile1.txt
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini
#RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN mkdir /var/www
RUN echo "<?php phpinfo(); ?>" > /var/www/index.php

EXPOSE 80

CMD service php5-fpm start && nginx
