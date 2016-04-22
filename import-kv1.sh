#!/usr/bin/env bash

set -e
set -o pipefail

cd ${SPARK_HOME}
./sbin/start-master.sh
./sbin/start-slave.sh spark://$(cat /etc/hostname):7077
sleep 10
./sbin/start-thriftserver.sh
sleep 20
./bin/beeline -u jdbc:hive2://$(cat /etc/hostname):10000/default -n abc -p abc -e "create table kv1 (key int, value string);load data local inpath '${SPARK_HOME}/examples/src/main/resources/kv1.txt' into table kv1; show tables;"
./sbin/stop-thriftserver.sh
./sbin/stop-slave.sh
./sbin/stop-master.sh

sleep 10
