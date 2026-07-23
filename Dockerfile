# PHP 8.2 with CLI
FROM php:8.2-cli

# Working directory set karo
WORKDIR /app

# System dependencies install karo
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    libcurl4-openssl-dev \
    && docker-php-ext-install \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    zip \
    curl

# Composer install karo
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Application files copy karo
COPY . .

# Composer dependencies install (agar koi ho to)
RUN composer install --no-interaction --no-progress --ignore-platform-reqs || true

# Files permissions set karo
RUN chmod 755 bot.php

# Bot start karo
CMD ["php", "bot.php"]
