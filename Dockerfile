FROM ubuntu:xenial-20181005

MAINTAINER Erwin "m9207216@gmail.com"

#https://github.com/sameersbn/docker-gitlab/blob/master/Dockerfile
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    wget ca-certificates apt-transport-https git ssh fping \
# https://askubuntu.com/questions/786272/why-does-installing-node-6-x-on-ubuntu-16-04-actually-install-node-4-2-6
 && echo "deb https://deb.nodesource.com/node_6.x xenial main" >> /etc/apt/sources.list.d/nodesource.list \
 && wget --quiet -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y nodejs curl locales \
 && update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX \
 && locale-gen en_US.UTF-8 \
 && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales \
 && npm install npm -g \
 && npm install hexo-cli -g \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 8010/TCP
VOLUME ["/root/tmp/.ssh"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD [ "app:web-service" ]
