# [<ru>] Основной backend-образ с приложением и php-fpm.
FROM php:8.5-fpm-alpine as backend
WORKDIR /app

RUN set -x \
    && apk add --no-cache \
        icu-libs \
        libstdc++ \
        bash \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        icu-dev \
        openssl-dev \
        linux-headers \
    && docker-php-source extract \
    # Исправлены названия папок: sockets (с 's')
    && for ext in sockets pcntl intl; do \
        cd /usr/src/php/ext/$ext; \
        phpize; \
        ./configure; \
        make -j$(nproc); \
        make install; \
    done \
    # Исправлены имена для включения: без .so и правильные названия
    && docker-php-ext-enable sockets pcntl intl \
    && docker-php-source delete \
    && apk del .build-deps \
    # Исправлен URL для composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer



# [<ru>] Копируем в образ файлы, нужные для установки зависимостей приложения.
COPY ./composer.* /app/
# [<ru>] Устанавливаем зависимости приложения (`dump-autoload` запустим после копирования остальных файлов приложения).
RUN composer install -n --no-dev --no-cache --no-ansi --no-autoloader --no-scripts --prefer-dist

# [<ru>] Копируем в образ все остальные файлы приложения.
COPY --chown=www-data:www-data . /app/
# [<ru>] Перегенерируем автозагрузчик классов.
RUN composer dump-autoload -n --optimize

# [<ru>] Копируем конфигурацию php-fpm.
COPY .docker/zzz-php-fpm-config.conf /usr/local/etc/php-fpm.d/zzz-php-fpm-config.conf

EXPOSE 9000

#############################################################################

# [<ru>] NGINX-образ с публичными файлами.
FROM nginx:stable-alpine as frontend
WORKDIR /www

# [<ru>] Копируем публичные файлы из backend образа.
COPY --from=backend /app/public /www

# [<ru>] Копируем конфигурацию NGINX.
COPY .docker/nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080
