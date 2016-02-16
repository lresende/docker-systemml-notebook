#!/bin/bash
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations

: ${HADOOP_PREFIX:=/opt/hadoop}

$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

rm /tmp/*.pid
mkdir -p /tmp/spark/data
mkdir -p /tmp/hadoop/hdfs/tmp

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

service sshd start

$HADOOP_PREFIX/sbin/start-all.sh

$SPARK_HOME/sbin/start-all.sh

$ZEPPELIN_HOME/bin/zeppelin-daemon.sh start

$HADOOP_PREFIX/bin/hadoop fs -mkdir -p /datasets/nyc-311-service
$HADOOP_PREFIX/bin/hadoop fs -put /opt/datasets/nyc-311-service/*.csv /datasets/nyc-311-service/

if [[ $1 = "-d" || $2 = "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 = "-bash" || $2 = "-bash" ]]; then
  /bin/bash
fi
