FROM mysql:8

ENV MYSQL_ROOT_PASSWORD dummy

EXPOSE 3306

COPY initdb/* /docker-entrypoint-initdb.d/
