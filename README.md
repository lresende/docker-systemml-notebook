# Getting Started with Apache SystemML

If you are here you have heard about Machine Learning and Apache SystemML, and this is going to enable you to quickly start exploring building Machine Learning algorithms using SystemML using Apache Zeppelin notebooks.

## Running
First, let's start by bringing up a small Spark one node cluster with 3 workers and Zeppelin all preconfigured and integrated with SystemML packaged as a docker image.

```
docker run -d --name systemml -p 7077:7077 -p 8080:8080 -p 8081:8081  -p 8085:8085 -p 8086:8086 -p 8087:8087 -p 8088:8088 -p 50070:50070 -p 6500:6500 -p 6501:6501 -p 6502:6502 -p 18080:18080 lresende/systemml
```

*Note:* If you are using docker via docker-machine, you need to identify the docker machine ip address, otherwise, in a native linux environment you could use localhost.

```
VM_IP="$(docker-machine ip default)"
```

And then access the different exposed UIs via

* Zepplin Notebook UI    http://$VM_IP:8081
* Spark Console http://$VM_IP:8080
* Yarn  Console http://$VM_IP:8088
* HDFS  Console http://$VM_IP:50070

## The Notebook

A sample 'SystemML - Linear Regression' notebook is provided with the image, and will enable you to a quickly see the power of SystemML and start hacking and customizing your machine learning algorithyms using R or Python like sintaxes

![](http://apache.github.io/incubator-systemml/img/spark-mlcontext-programming-guide/zeppelin-notebook.png)

![](http://apache.github.io/incubator-systemml/img/spark-mlcontext-programming-guide/zeppelin-notebook-systemml-linear-regression.png)

Hopefully this helps you get started, feel free to ask questions and submit bugs in the [Apache SystemML community](http://systemml.apache.org/community.html).

