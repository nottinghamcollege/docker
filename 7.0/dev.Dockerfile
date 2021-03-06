ARG PHP_VERSION
ARG PROJECT_TYPE
FROM craftcms/${PROJECT_TYPE}:${PHP_VERSION}

# disable opcache
ENV PHP_OPCACHE_ENABLE=0

USER root

RUN set -ex && \
    apk --no-cache add \
    autoconf \
    g++ \
    make \
    mysql-client \
    postgresql-client \
    git \
    && \
    apk del --no-cache \
    autoconf \
    g++ \
    make

# install composer
RUN set -ex && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# downgrade composer to version 1
RUN set -ex && composer self-update --1

# expose the xdebug port
EXPOSE 9003

USER www-data
