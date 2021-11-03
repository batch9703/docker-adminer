# docker-adminer
small database management tool on docker.  
docker execute adminer (mysql-en).  
adminer with env parameter.  
If you are not in Japan, change the "TZ" and "LANG" of the Dockerfile and then "docker build" again.
## ENV parameter
* `ADMINER_NAME`: html title.
* `ADMINER_AUTOLOGIN`: true: auto login, false: not login
* `ADMINER_SERVER`: Database host name + ":" + port no. ("3306" if not set.)
* `ADMINER_DB`: Database name
* `ADMINER_USERNAME`: Database user
* `ADMINER_PASSWORD`: Database password
