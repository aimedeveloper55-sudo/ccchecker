FROM php:8.2-cli

WORKDIR /app

# Install all dependencies including curl
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
    pkg-config \
    && docker-php-ext-install \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    zip \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy code
COPY . .

# Composer install
RUN composer install --no-interaction --no-progress --ignore-platform-reqs || true

# Permissions
RUN chmod 755 bot.php

# Start bot
CMD ["php", "bot.php"]
