#!/usr/bin/env bash

set -e
set -o pipefail

#sleep 10

HOSTNAME=$(cat /etc/hostname)
# cannot use localhost here, slave won't find master
${SPARK_HOME}/sbin/start-slave.sh spark://${HOSTNAME}:7077

# get pid
# get all java | get slave | remove leading spaces | get pid
PG_PID=$(ps -o pid,cmd -C java | grep "org.apache.spark.deploy.worker.Worker" | sed -e 's/^[ \t]*//' | cut -d' ' -f 1)
echo "spark-slave started with pid=${PG_PID}"

# wait until it dies
while [ -e /proc/${PG_PID} ]; do sleep 1; done

