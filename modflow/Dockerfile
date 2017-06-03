FROM debian:jessie

MAINTAINER Ralf Junghanns <ralf.junghanns@gmail.com>

RUN buildDeps="python3 python3-dev python3-pip python3-matplotlib python3-numpy python3-scipy g++ netcat" && \
    apt-get update && \
    apt-get install -y $buildDeps --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install flopy && \
    pip3 install sklearn && \
    pip3 install pika

