# rzhilkibaev/spark-standalone-thrift
[![](http://dockeri.co/image/rzhilkibaev/spark-standalone-thrift)](https://registry.hub.docker.com/u/rzhilkibaev/spark-standalone-thrift/)

[Standalone Spark](http://spark.apache.org/docs/latest/spark-standalone.html) with [Thrift](http://spark.apache.org/docs/latest/sql-programming-guide.html#running-the-thrift-jdbcodbc-server)

This image is intended to be used for testing purposes.

# How to use this image

    docker run -p 10000:10000 rzhilkibaev/spark-standalone-thrift
This will start up Spark in standalone mode along with Thrift server listening on port `10000`.
