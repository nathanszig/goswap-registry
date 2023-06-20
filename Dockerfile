# From php fpm
FROM php:8.2-fpm

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Git clone
RUN git clone https://github.com/pgrimaud/go-swap.git

# Set working directory
WORKDIR /var/www/html/go-swap

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install dependencies
RUN COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_MEMORY_LIMIT=-1 \
    composer install --no-dev --no-scripts --no-progress --prefer-dist --no-interaction 

# Expose port 9000 and start php-fpm server
EXPOSE 9000

CMD ["php-fpm"]