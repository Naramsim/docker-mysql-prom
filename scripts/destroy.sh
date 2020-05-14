#!/bin/sh

destroy(){
    docker-compose -f application.yml down
    docker-compose -f exporters.yml down
    docker-compose -f monitoring.yml down
}

cd ../compose || exit 1

destroy
destroy

cd -

echo "Completed destroy: $(date)"
