FROM alpine:3.17

LABEL maintainer="batch9703"

ARG TZ="Asia/Tokyo"
ARG php_ver="8.1.16-r0"
ARG ad_ver="4.8.1"
ARG DIR="/opt/dbadmin"

ENV LANG="ja_JP.UTF-8"

WORKDIR ${DIR}

RUN set -x \
 && apk update && apk upgrade \
 && apk add --no-cache --virtual .build-deps curl tzdata \
 && \
 : "php" \
 && apk add --no-cache \
    php81=${php_ver} \
    php81-opcache=${php_ver} \
    php81-pdo=${php_ver} \
    php81-pdo_mysql=${php_ver} \
    php81-pdo_odbc=${php_ver} \
    php81-pdo_pgsql=${php_ver} \
    php81-pdo_sqlite=${php_ver} \
    php81-session=${php_ver} \
 && \
 : "adminer" \
 && curl -L https://github.com/vrana/adminer/releases/download/v${ad_ver}/adminer-${ad_ver}-mysql-en.php -o adminer.php \
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
