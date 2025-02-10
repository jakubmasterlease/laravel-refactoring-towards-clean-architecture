FROM php:8.1-cli

RUN apt-get update && apt-get install -y libpq-dev git libzip-dev zip unzip
RUN docker-php-ext-install pdo pdo_pgsql zip
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# default in the JetBrains IDE
WORKDIR /opt/project

COPY . .

RUN composer install

# Eksponowanie portu
EXPOSE 8000

CMD ["php", "artisan", "serve", "--host", "0.0.0.0", "--port", "8000"]
