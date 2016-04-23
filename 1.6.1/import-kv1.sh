#!/usr/bin/env bash

set -e
set -o pipefail

# create data directory
mkdir -p /user/hive/warehouse

keeptrying() {
    local counter=20
    while ! "$@" ; do   
        ((counter--))
        if [[ $counter = 0 ]];then
            break
        fi
        sleep 3
    done
}

cd ${SPARK_HOME}

./sbin/start-master.sh
./sbin/start-slave.sh spark://$(cat /etc/hostname):7077
./sbin/start-thriftserver.sh

keeptrying ./bin/beeline -u jdbc:hive2://$(cat /etc/hostname):10000/default -n abc -p abc -e "create table kv1 (key int, value string);load data local inpath '${SPARK_HOME}/examples/src/main/resources/kv1.txt' into table kv1; show tables;"

./sbin/stop-thriftserver.sh
./sbin/stop-slave.sh
./sbin/stop-master.sh

sleep 3
