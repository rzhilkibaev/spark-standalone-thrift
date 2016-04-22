#!/usr/bin/env bash

set -e
set -o pipefail

sleep 20

# I don't know why but you have to cd there or otherwise 
# thrift won't show tables
cd ${SPARK_HOME}
${SPARK_HOME}/sbin/start-thriftserver.sh

# get pid
# get all java | get thrift | remove leading spaces | get pid
PG_PID=$(ps -o pid,cmd -C java | grep "org.apache.spark.sql.hive.thriftserver.HiveThriftServer2" | sed -e 's/^[ \t]*//' | cut -d' ' -f 1)
echo "thrift started with pid=${PG_PID}"

# wait until it dies
while [ -e /proc/${PG_PID} ]; do sleep 1; done

