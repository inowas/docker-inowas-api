FROM php:7.1-fpm

MAINTAINER Ralf Junghanns <ralf.junghanns@gmail.com>

RUN apt-get update

# Install bcmath
RUN docker-php-ext-install bcmath

# Install bz2
RUN apt-get install -y libbz2-dev
RUN docker-php-ext-install bz2

# Install gd
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

# Install mbstring
RUN docker-php-ext-install mbstring

# Install mcrypt
RUN apt-get install -y libmcrypt-dev
RUN docker-php-ext-install mcrypt

# Install pdo
RUN docker-php-ext-install pdo
# RUN apt-get install -y freetds-dev php5-sybase
# RUN docker-php-ext-install pdo_mysql
# RUN docker-php-ext-install pdo_oci
# RUN docker-php-ext-install pdo_odbc

RUN apt-get install -y libpq-dev
RUN docker-php-ext-install pgsql
RUN docker-php-ext-install pdo_pgsql

# Install zip and git functionality
RUN apt-get install -y git zlib1g-dev
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

RUN pecl install xdebug

COPY xdebug.ini $PHP_INI_DIR/conf.d/

WORKDIR /var/www/symfony
