FROM phusion/baseimage:0.9.18

ENV SPARK_VER 1.6.1
ENV SPARK_HOME=/opt/spark

RUN add-apt-repository -y ppa:openjdk-r/ppa
RUN apt-get update && apt-get install -y openjdk-8-jdk

# install spark
RUN mkdir -p $SPARK_HOME && \
  cd $SPARK_HOME && \
  curl -o spark.tgz http://mirrors.ocf.berkeley.edu/apache/spark/spark-${SPARK_VER}/spark-${SPARK_VER}-bin-hadoop2.6.tgz && \
  tar --strip-components=1 -xzf spark.tgz && \
  rm spark.tgz

# configure services
RUN mkdir -p /etc/service/spark-master && \
  mkdir -p /etc/service/spark-slave && \
  mkdir -p /etc/service/thrift

COPY run-spark-master.sh /etc/service/spark-master/run
COPY run-spark-slave.sh /etc/service/spark-slave/run
COPY run-thrift.sh /etc/service/thrift/run

# master web UI, slave web UI, thrift jdbc, master, SparkUI
EXPOSE 8080 8081 10000 7077 4040

RUN mkdir -p /user/hive/warehouse
COPY import-kv1.sh /opt/
RUN /opt/import-kv1.sh
