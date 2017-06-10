FROM ubuntu:15.10

MAINTAINER Frank Lemanschik, Alexandre Moraes <https://github.com/alcmoraes>

# Update the package repository
RUN apt-get -qq update

# Install base system
RUN apt-get install -y varnish

ADD start.sh /tmp/

RUN chmod +x /tmp/start.sh

EXPOSE 80

CMD ["bash", "/tmp/start.sh"]
