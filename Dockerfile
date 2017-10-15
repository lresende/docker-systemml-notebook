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

#####################################
# Basic CentoOS Image
#

FROM lresende/spark:2.2.0
MAINTAINER Luciano Resende lresende@apache.org

USER root

# Clean metadata to avoid 404 erros from yum
RUN yum clean all

#####################
# Zeppelin

RUN curl -s 'http://archive.apache.org/dist/zeppelin/zeppelin-0.7.3/zeppelin-0.7.3-bin-all.tgz' | tar -xz -C /opt/ && \
    rm -rf zeppelin-0.7.3-bin-all.tgz && \
    cd /opt && ln -s ./zeppelin-0.7.3-bin-all zeppelin

ADD zeppelin/conf/zeppelin-env.sh /opt/zeppelin/conf/

ENV ZEPPELIN_HOME /opt/zeppelin

#####################
# SystemML

RUN mkdir /opt/systemml && \
    cd /opt/systemml && curl -s 'https://repository.apache.org/content/repositories/releases/org/apache/systemml/systemml/0.15.0/systemml-0.15.0.jar' -o systemml-0.15.0.jar

ADD zeppelin/notebook/ /opt/zeppelin/notebook
RUN mkdir /opt/datasets
ADD datasets /opt/datasets

#####################
# clean yum cache

RUN yum clean all

#####################

ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && \
    chmod 700 /etc/bootstrap.sh

ENV BOOTSTRAP /etc/bootstrap.sh

CMD ["/etc/bootstrap.sh", "-d"]

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090
# Mapred ports
EXPOSE 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
EXPOSE 49707 2122   
# Spark submit, admin console, executor, history server
EXPOSE 7077 8080 65000 65001 65002 8085 8086 8087 18080
# Zeppelin
EXPOSE 8081