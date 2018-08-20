FROM python:3.6-stretch

MAINTAINER Ralf Junghanns <ralf.junghanns@gmail.com>

RUN buildDeps="netcat" && \
    apt-get update && \
    apt-get install -y $buildDeps --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install docker
RUN pip install pika
