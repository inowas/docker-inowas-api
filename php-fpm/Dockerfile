# See https://github.com/docker-library/php/blob/4677ca134fe48d20c820a19becb99198824d78e3/7.0/fpm/Dockerfile
FROM php:7.1-fpm
MAINTAINER Ralf Junghanns <ralf.junghanns@gmail.com>

RUN buildDeps="libfreetype6-dev libjpeg-dev libmcrypt-dev libpq-dev libpng12-dev zlib1g-dev libzip-dev libicu-dev" && \
    apt-get update && \
    apt-get install -y $buildDeps --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-install \
        gd \
        pdo \
        pdo_pgsql \
        pgsql \
        sockets \
        intl

RUN geosBuildDeps="wget autoconf make automake build-essential libtool" && \
    apt-get update && \
    apt-get install -y $geosBuildDeps --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Geos
WORKDIR /tmp
RUN wget https://github.com/libgeos/libgeos/archive/3.4.3.tar.gz
RUN tar zxf 3.4.3.tar.gz
RUN cd geos-3.4.3 && ./autogen.sh && ./configure --prefix=/usr && make && make install

RUN wget https://github.com/libgeos/php-geos/archive/1.0.0.tar.gz
RUN tar zxf 1.0.0.tar.gz
RUN cd php-geos-1.0.0 && ./autogen.sh && ./configure && make && mv modules/geos.so $(php-config --extension-dir)
RUN docker-php-ext-enable geos
