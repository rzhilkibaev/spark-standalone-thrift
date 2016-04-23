# rzhilkibaev/spark-standalone-thrift

# Supported tags and respective `Dockerfile` links

- [`1.5.2` (*1.5.2/Dockerfile*)](https://github.com/rzhilkibaev/spark-standalone-thrift/blob/master/1.5.2/Dockerfile)
- [`1.6.1` (*1.6.1/Dockerfile*)](https://github.com/rzhilkibaev/spark-standalone-thrift/blob/master/1.6.1/Dockerfile)

[![Docker Pulls](https://img.shields.io/docker/pulls/rzhilkibaev/spark-standalone-thrift.svg?maxAge=2592000)](https://hub.docker.com/r/rzhilkibaev/spark-standalone-thrift/)

[Standalone Spark](http://spark.apache.org/docs/latest/spark-standalone.html) with [Thrift](http://spark.apache.org/docs/latest/sql-programming-guide.html#running-the-thrift-jdbcodbc-server)

This image is intended to be used for testing purposes.

# How to use this image

    docker run -p 10000:10000 rzhilkibaev/spark-standalone-thrift
This will start up Spark in standalone mode along with Thrift server listening on port `10000`.
