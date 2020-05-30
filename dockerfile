# Using ubuntu as a base image
FROM ubuntu:18.04

# Getting rid of debconf messages
ARG DEBIAN_FRONTEND=noninteractive

ARG realm="realm_you_want"

ARG public_ip

ARG user_name="user"

ARG password="password"


RUN apt-get update sudo && \
  apt-get install coturn sudo

RUN chmod 700 /etc/turnserver.conf sudo

RUN echo "realm=$realm
fingerprint
external-ip=$public_ip
listening-port=3478
min-port=10000
max-port=20000
log-file=/var/log/turnserver.log
verbose
user=$user_name:$password
" >> /etc/coturn/turnserver.conf

EXPOSE 3478 3478/udp

VOLUME ["/var/lib/coturn"]

CMD ["sudo","service","coturn","start"]


CMD ["--log-file=stdout"]
