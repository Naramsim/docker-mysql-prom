#!/bin/sh

cd ../compose || exit 1

docker-compose -f application.yml up -d
docker-compose -f exporters.yml up -d
docker-compose -f monitoring.yml up -d

cd -

echo "Completed bootstrap: $(date)"
