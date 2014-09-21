FROM debian:wheezy
MAINTAINER Ivan Shakuta "ishakuta@gmail.com"

# update and install tools
RUN apt-get -qy update && \
	DEBIAN_FRONTEND=noninteractive apt-get -qy --no-install-recommends install apt-utils && \
	DEBIAN_FRONTEND=noninteractive apt-get -qy --no-install-recommends install \
	nano wget curl software-properties-common openssh-server git-core supervisor && \
	
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /var/run/sshd && mkdir -p /var/log/supervisor

# generate password and setup user ubuntu with ubuntu password
RUN echo root:root | chpasswd && \
    useradd ubuntu -s /bin/bash -m -p `perl -e 'print crypt("ubuntu", "salt"),"\n"'` && \
    echo 'ubuntu	ALL=(ALL:ALL) ALL' >> /etc/sudoers && \
	
	echo '[program:sshd]' > /etc/supervisor/conf.d/sshd.conf && \
	echo 'command=/usr/sbin/sshd -D' >> /etc/supervisor/conf.d/sshd.conf 

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 22
EXPOSE 9001
CMD ["/usr/bin/supervisord"]
