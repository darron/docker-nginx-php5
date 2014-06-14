FROM ubuntu:14.04
MAINTAINER Ivan Shakuta "ishakuta@gmail.com"

# TODO: add gpg key here instead of add-apt-repository (that needs python, etc)

# update and install tools
RUN apt-get -qy update && locale-gen en_US.UTF-8 && \
	DEBIAN_FRONTEND=noninteractive apt-get -qy install \
	nano wget curl software-properties-common openssh-server git

# compose simple start script
RUN mkdir /var/run/sshd && \
    echo "#!/bin/bash" >> /run.sh && \
    echo "/usr/sbin/sshd &" >> /run.sh && \
    chmod +x /run.sh

# generate password and setup user ubuntu with ubuntu password
RUN echo root:root | chpasswd && \
    useradd ubuntu -s /bin/bash -m -p `perl -e 'print crypt("ubuntu", "salt"),"\n"'` && \
    echo 'ubuntu	ALL=(ALL:ALL) ALL' >> /etc/sudoers

ENTRYPOINT ["/run.sh"]
