FROM postgres:11-alpine

ENV POSTGRES_DB wiki
ENV POSTGRES_USER wikijs
ENV POSTGRES_PASSWORD wikijsrocks
ENV PGDATA /var/lib/postgresql/data

COPY ./wiki.sql ./docker-entrypoint-initdb.d

EXPOSE 5432