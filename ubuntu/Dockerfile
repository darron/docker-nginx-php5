FROM ubuntu:14.04
MAINTAINER Ivan Shakuta "ishakuta@gmail.com"

# TODO: add gpg key here instead of add-apt-repository (that needs python, etc)

# update and install tools
RUN apt-get -qy update && locale-gen en_US.UTF-8 && \
	DEBIAN_FRONTEND=noninteractive apt-get -qy install \
	nano wget curl software-properties-common openssh-server \
	git supervisor

# generate password and setup user ubuntu with ubuntu password
RUN echo root:root | chpasswd && \
    useradd ubuntu -s /bin/bash -m -p `perl -e 'print crypt("ubuntu", "salt"),"\n"'` && \
    echo 'ubuntu	ALL=(ALL:ALL) ALL' >> /etc/sudoers && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && mkdir /var/run/sshd

ADD config/etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf && \
echo '[program:sshd]
command=/usr/sbin/sshd -D' > /usr/local/etc/supervisor.d/sshd.conf

EXPOSE 22
CMD ["/usr/bin/supervisord"]
