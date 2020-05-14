#!/bin/bash

set -x

tables=10

prepare(){
    echo 'Preparing'
    sysbench \
    --db-driver=mysql \
    --oltp-table-size=10000 \
    --oltp-tables-count="$tables" \
    --threads=1 \
    --mysql-host="${MYSQL_HOST}" \
    --mysql-port="${MYSQL_PORT}" \
    --mysql-user="${MYSQL_USER}" \
    --mysql-password="${MYSQL_PASSWORD}" \
    --mysql-db="application" \
    /usr/share/sysbench/tests/include/oltp_legacy/parallel_prepare.lua \
    run
}

benchmark(){
    echo 'Benchmarking'
    sysbench \
    --db-driver=mysql \
    --report-interval=2 \
    --mysql-table-engine=innodb \
    --oltp-table-size=10000 \
    --oltp-tables-count="$tables" \
    --threads=64 \
    --time=10 \
    --mysql-host="${MYSQL_HOST}" \
    --mysql-port="${MYSQL_PORT}" \
    --mysql-user="${MYSQL_USER}" \
    --mysql-password="${MYSQL_PASSWORD}" \
    --mysql-db="${MYSQL_DATABASE}" \
    /usr/share/sysbench/tests/include/oltp_legacy/oltp.lua \
    run
}

clean(){
    echo 'Cleaning'
    sysbench \
    --db-driver=mysql \
    --oltp-tables-count="$tables" \
    --mysql-host="${MYSQL_HOST}" \
    --mysql-port="${MYSQL_PORT}" \
    --mysql-user="${MYSQL_USER}" \
    --mysql-password="${MYSQL_PASSWORD}" \
    --mysql-db="${MYSQL_DATABASE}" \
    /usr/share/sysbench/tests/include/oltp_legacy/oltp.lua \
    cleanup
}

run(){
    index=1
    while true; do
        sleep 10
        if [ "$(( index%5 ))" -eq 0 ]; then
            clean
            prepare
        else
            benchmark
        fi
        (( index++ ))
    done
}

# sleep 20 # TODO: replace with `mysqladmin ping -h "$MYSQL_HOST"`
clean
prepare
run
