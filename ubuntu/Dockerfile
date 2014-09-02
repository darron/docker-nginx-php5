FROM debian:wheezy
MAINTAINER Ivan Shakuta "ishakuta@gmail.com"

# TODO: add gpg key here instead of add-apt-repository (that needs python, etc)

# update and install tools
RUN apt-get -qy update && \
	DEBIAN_FRONTEND=noninteractive apt-get -qy install apt-utils && \
	apt-get -qy install nano wget curl software-properties-common openssh-server \
	git supervisor && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /var/run/sshd && mkdir -p /var/log/supervisor

# generate password and setup user ubuntu with ubuntu password
RUN echo root:root | chpasswd && \
    useradd ubuntu -s /bin/bash -m -p `perl -e 'print crypt("ubuntu", "salt"),"\n"'` && \
    echo 'ubuntu	ALL=(ALL:ALL) ALL' >> /etc/sudoers
    
ADD config/etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf && \
	echo '[program:sshd]' > /usr/local/etc/supervisor.d/sshd.conf && \
	echo 'command=/usr/sbin/sshd -D' >> /usr/local/etc/supervisor.d/sshd.conf 

EXPOSE 22
CMD ["/usr/bin/supervisord"]
