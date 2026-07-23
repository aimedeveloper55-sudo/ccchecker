FROM php:8.2-cli

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip curl

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY . .

RUN composer install --no-interaction --no-progress --ignore-platform-reqs || true
RUN chmod 755 bot.php

CMD ["php", "bot.php"]
