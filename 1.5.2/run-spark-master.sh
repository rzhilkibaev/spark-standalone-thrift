#!/usr/bin/env bash

set -e
set -o pipefail

${SPARK_HOME}/sbin/start-master.sh

# get pid
# get all java | get master | remove leading spaces | get pid
PG_PID=$(ps -o pid,cmd -C java | grep "org.apache.spark.deploy.master.Master" | sed -e 's/^[ \t]*//' | cut -d' ' -f 1)
echo "spark-master started with pid=${PG_PID}"

# wait until it dies
while [ -e /proc/${PG_PID} ]; do sleep 1; done

