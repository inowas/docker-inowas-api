FROM php:latest

MAINTAINER Ralf Junghanns <ralf.junghanns@gmail.com>

RUN buildDeps="netcat" && \
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

# CleanUp
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN "date"

RUN echo 'alias cs="php bin/console"' >> ~/.bashrc

WORKDIR /var/www/symfony
