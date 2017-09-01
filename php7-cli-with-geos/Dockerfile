FROM php:latest

MAINTAINER Ralf Junghanns <ralf.junghanns@gmail.com>

RUN buildDeps="netcat git zlib1g-dev" && \
    apt-get update && \
    apt-get install -y $buildDeps --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update

# Install bcmath
RUN docker-php-ext-install bcmath

# Install mbstring
RUN docker-php-ext-install mbstring

# Install pdo
RUN docker-php-ext-install pdo
RUN apt-get install -y libpq-dev
RUN docker-php-ext-install pgsql
RUN docker-php-ext-install pdo_pgsql

# Install zip and git functionality
RUN docker-php-ext-install zip

# CleanUp
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

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

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN "date"

RUN echo 'alias cs="php bin/console"' >> ~/.bashrc
RUN echo 'alias cscc="php bin/console cache:clear --env=prod && php bin/console cache:clear --env=dev && php bin/console cache:clear --env=test"' >> ~/.bashrc

RUN pecl install xdebug

COPY xdebug-cli.ini $PHP_INI_DIR/conf.d/

WORKDIR /var/www/symfony
