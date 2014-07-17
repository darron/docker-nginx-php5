#!/bin/bash
mkdir /var/run/sshd
cowsay "Welcome to docker container! Moo..."
/usr/bin/supervisord
