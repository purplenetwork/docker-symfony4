# Build arguments
ARG IMAGE
ARG APP_PATH=.

FROM webdevops/php-nginx:alpine-php7

RUN apk add --no-cache --upgrade php7-memcached

ARG COMPOSER_VERSION=1.8.5

RUN echo ${SYMFONY_ENV}
RUN echo ${WEB_ALIAS_DOMAIN}


# TimeZone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Rome /etc/localtime \
    && echo Europe/Rome > /etc/timezone

# Install composer
RUN wget https://getcomposer.org/download/${COMPOSER_VERSION}/composer.phar
RUN chmod +x composer.phar
RUN mv composer.phar /usr/local/bin/composer

# Add prestissimo
RUN composer global require "hirak/prestissimo"

#Set php.ini
#RUN echo opcache.validate_timestamps = 0 >> /opt/docker/etc/php/php.ini