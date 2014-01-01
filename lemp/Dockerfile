FROM ishakuta/docker-nginx-php5
MAINTAINER Ivan Shakuta "ishakuta@gmail.com"

# comment this line when building from stackbrew-based images
# RUN dpkg-divert --local --rename --add /sbin/initctl && ln -s /bin/true /sbin/initctl

RUN DEBIAN_FRONTEND=noninteractive apt-get -qy update
RUN DEBIAN_FRONTEND=noninteractive apt-get -qy install mysql-server
RUN apt-get -qy clean

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
RUN echo "#!/bin/bash" > /run.sh && \
    echo "service php5-fpm start" >> /run.sh && \
    echo "/usr/sbin/sshd" >> /run.sh && \
    echo "/usr/bin/mysqld_safe &" >> /run.sh && \
    echo "/usr/sbin/nginx" >> /run.sh && chmod +x /run.sh

EXPOSE 3306
