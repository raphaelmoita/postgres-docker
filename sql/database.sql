CREATE ROLE moita_app LOGIN PASSWORD 'p4ssw0rd';

CREATE DATABASE moita_db
WITH
    ENCODING = 'UTF-8'
    OWNER = moita_app
    CONNECTION LIMIT 10;