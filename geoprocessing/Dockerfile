FROM debian:jessie

MAINTAINER Ralf Junghanns <ralf.junghanns@gmail.com>

RUN buildDeps="python3 python3-dev python3-gdal python3-matplotlib python3-numpy python3-pillow python3-pip python3-scipy python3-setuptools g++ netcat libgdal-dev" && \
    apt-get update && \
    apt-get install -y $buildDeps --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install pika && \
    pip3 install gdal
