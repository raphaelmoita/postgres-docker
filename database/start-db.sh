#!/bin/bash
. variables.sh

docker image inspect ${IMAGE}:${TAG} > /dev/null 2>&1

if [ $? -ne 0 ]; then
    docker pull ${IMAGE}:${TAG}
fi

docker stop ${CONTAINER} 2> /dev/null
docker rm ${CONTAINER} 2> /dev/null

echo "Starting server ..."
docker run -d \
    --name ${CONTAINER} \
    --network ${NETWORK} \
    -p ${DB_PORT}:${DB_PORT} \
    -e POSTGRES_USER=${DB_USER} \
    -e POSTGRES_PASSWORD=${DB_PASS} \
    postgres

sleep 5

echo "Connecting to the server ..."
docker run -it --rm \
    --network ${NETWORK} \
    -e PGPASSWORD=${DB_PASS} \
    postgres psql -h ${CONTAINER} -U ${DB_USER}