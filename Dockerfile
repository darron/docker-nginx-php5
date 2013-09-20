FROM base

MAINTAINER Ivan Shakuta "ishakuta@gmail.com"

#RUN echo "deb http://archive.ubuntu.com/ubuntu/ raring universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install nano wget curl software-properties-common
RUN add-apt-repository -y ppa:nginx/stable
#RUN add-apt-repository -y ppa:ondrej/php5-oldstable
RUN apt-get update

RUN apt-get -y install nginx php5-fpm php5-mysql php5-imagick php5-mcrypt

CONF="server {
    listen 80 default_server;
    listen [::]:80 default_server ipv6only=on;

    root /var/www;
    index index.html index.php;

    # Make site accessible from http://localhost/
    server_name localhost;

    location / {
        try_files \$uri \$uri/ /index.php;
    }

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        # NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini

        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_index index.php;
        include fastcgi_params;
    }

}"

RUN echo "$CONF" > /etc/nginx/sites-available/default
#RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini

RUN mkdir /var/www
RUN echo "<?php phpinfo(); ?>" > /var/www/index.php

EXPOSE 80

CMD service php5-fpm start && nginx

