FROM php:7.3-fpm

LABEL maintainer="yoru"

COPY sources.list /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
      libfreetype6-dev \
      libjpeg62-turbo-dev \
      libpng-dev \
      zip unzip acl \
      libav-tools \
      graphicsmagick imagemagick \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure \
       gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install exif \
    && docker-php-ext-enable exif

WORKDIR /app
COPY ./_h5ai /app/_h5ai
RUN chown www-data /app/_h5ai/public/cache/
RUN chown www-data /app/_h5ai/private/cache/

EXPOSE 9000

VOLUME [ "/app", "/var/www" ]
