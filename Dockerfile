FROM alpine:3.21

ARG TZ="Asia/Tokyo"
ARG php_ver="8.3.17-r0"
ARG ad_ver="5.0.1"
ARG DIR="/opt/dbadmin"

ENV LANG="ja_JP.UTF-8"

WORKDIR ${DIR}

RUN set -x \
 && apk update && apk upgrade \
 && apk add --no-cache --virtual .build-deps curl tzdata \
 && \
 : "php" \
 && apk add --no-cache \
    php83=${php_ver} \
    php83-opcache=${php_ver} \
    php83-pdo=${php_ver} \
    php83-pdo_mysql=${php_ver} \
    php83-pdo_odbc=${php_ver} \
    php83-pdo_pgsql=${php_ver} \
    php83-pdo_sqlite=${php_ver} \
    php83-session=${php_ver} \
 && \
 : "adminer" \
 && curl -L https://github.com/vrana/adminer/releases/download/v${ad_ver}/adminer-${ad_ver}-en.php -o adminer.php \
 && \
 : "permission" \
 && addgroup -S dbadmin \
 && adduser -S -G dbadmin dbadmin \
 && chown -R dbadmin:dbadmin ${DIR} \
 && chmod -R 755 ${DIR} \
 && \
 : "timezones" \
 && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
 && \
 : "end proccess" \
 && apk del -f .build-deps \
 && rm -rf /tmp/*

COPY index.php ${DIR}/index.php
COPY php.ini /etc/php8/conf.d/99_docker.ini

USER dbadmin

EXPOSE 8080

CMD [ "php", "-S", "[::]:8080" ]
