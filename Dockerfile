# Using ubuntu as a base image
FROM ubuntu:18.04

# Getting rid of debconf messages
ARG DEBIAN_FRONTEND=noninteractive

ARG BUILD_SCRIPT_HOME=/usr/local/bin
ARG BUILD_REALM=realm_you_want
ARG BUILD_PUBLICIP=8.8.8.8
ARG BUILD_USERNAME=user
ARG BUILD_PASSWORD=password

ENV SCRIPT_HOME=$BUILD_SCRIPT_HOME
ENV REALM=$BUILD_REALM
ENV PUBLICIP=$BUILD_PUBLICIP
ENV USERNAME=$BUILD_USERNANE
ENV PASSWORD=$BUILD_PASSWORD

# Install dependencies
RUN set -x && \
    apt-get update -y && \
    apt-get install -y apt-utils && \
    apt-get install -y dumb-init git

# Entrypoint script
COPY docker-entrypoint.sh $SCRIPT_HOME/docker-entrypoint.sh
RUN chmod +x $SCRIPT_HOME/docker-entrypoint.sh

EXPOSE 3478 3478/udp

VOLUME ["/var/lib/coturn"]

ENTRYPOINT ["/usr/bin/dumb-init", "--", "docker-entrypoint.sh"]
CMD ["up"]
