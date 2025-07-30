# Use up-to-date Debian as base
FROM ubuntu:22.04

# Set build arguments for PHP and Composer versions
ARG PHP_VERSION=5.6
ARG COMPOSER_VERSION=2.2.25

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV TZ=Europe/Berlin

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        gnupg2 \
        unzip \
        ssh-client \
        git \
        gpg \
        software-properties-common && \
    rm -rf /var/lib/apt/lists/*

RUN add-apt-repository -y ppa:ondrej/php && \ 
    rm -rf /var/lib/apt/lists/*


RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libapache2-mod-php${PHP_VERSION} \
        php${PHP_VERSION} \
        php${PHP_VERSION}-cli \
        php${PHP_VERSION}-common \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-json \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-opcache \
        php${PHP_VERSION}-readline \
        php${PHP_VERSION}-ssh2 \
        php${PHP_VERSION}-xml \
        php${PHP_VERSION}-xsl \
        php${PHP_VERSION}-zip && \
    rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -fsSL https://getcomposer.org/download/${COMPOSER_VERSION}/composer.phar -o /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

# Set default PHP and Composer versions as environment variables
ENV PHP_VERSION=${PHP_VERSION}
ENV COMPOSER_VERSION=${COMPOSER_VERSION}

# Show versions
RUN php -v && composer --version

# Set working directory
WORKDIR /app

ENTRYPOINT ["composer"]

# Default command
CMD ["--version"]
