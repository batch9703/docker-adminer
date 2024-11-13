# docker-adminer
small database management tool on docker.  
docker execute adminer.  
adminer with env parameter.  
If you are not in Japan, change the "TZ" and "LANG" of the Dockerfile and then "docker build" again.
## ENV parameter
* `ADMINER_NAME`: html title.
* `ADMINER_AUTOLOGIN`: true: auto login, false: not login
* `ADMINER_DRIVER`: MySQL: server, SQLite: sqlite, PostgreSQL: pgsql, Oracle: oracle, MS SQL: mssql, MongoDB: mongo, Elasticsearch: elastic
* `ADMINER_SERVER`: Database host name + ":" + port no. (default port if not set.)
* `ADMINER_DB`: Database name
* `ADMINER_USERNAME`: Database user
* `ADMINER_PASSWORD`: Database password
