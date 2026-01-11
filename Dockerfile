FROM php:8.1-cli


RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo pdo_mysql zip


RUN { \
    echo 'upload_max_filesize = 4G'; \
    echo 'post_max_size = 4G'; \
    echo 'memory_limit = 512M'; \
    echo 'max_execution_time = 300'; \
    echo 'max_input_time = 300'; \
    echo 'opcache.enable = 1'; \
    echo 'opcache.memory_consumption = 128'; \
    echo 'opcache.interned_strings_buffer = 8'; \
    echo 'opcache.max_accelerated_files = 4000'; \
} > /usr/local/etc/php/conf.d/custom.ini


WORKDIR /app


COPY . /app


RUN chown -R www-data:www-data /app


EXPOSE 80


CMD ["php", "-S", "0.0.0.0:80", "-t", "/app"]
