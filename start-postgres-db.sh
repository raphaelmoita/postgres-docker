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
    -p ${DB_PORT}:${DB_PORT} \
    -e POSTGRES_PASSWORD=${DB_PASS} \
    ${IMAGE}

# docker exec -it ${CONTAINER} bash -c "while ! echo exit | nc localhost ${DB_POST}; do sleep 5; done"
sleep 10

echo "Creating database ..."
docker exec -i ${CONTAINER} psql -U postgres < ${DATABASE_SQL}

echo "Creating tables ..."
docker exec -i ${CONTAINER} psql -d ${DB_DATABASE} -U ${DB_USER} < ${TABLES_SQL}