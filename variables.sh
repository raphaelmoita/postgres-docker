#!/bin/bash

IMAGE=postgres
TAG=13.2-alpine

CONTAINER=moita-database
NETWORK=moita-network

DB_DATABASE=moita_db
DB_USER=moita_app
DB_PASS=p4ssw0rd
DB_PORT=5432

DATABASE_SQL=sql/database.sql
TABLES_SQL=sql/tables.sql