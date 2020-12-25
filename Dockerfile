FROM openjdk:11-jre-slim

ENV DZ_VERSION=3.6.2
ENV DZ_CONF_DIR=/etc/zookeeper
ENV DZ_WORK_DIR=/opt/zookeeper
ENV DZ_DATA_DIR=/var/lib/zookeeper
ENV DZ_LOG_DIR=/var/log/zookeeper
ENV DZ_MYID=1
# ZK variables
ENV ZOO_LOG_DIR=${DZ_LOG_DIR}

RUN adduser --group --system --no-create-home zookeeper

RUN mkdir -p ${DZ_CONF_DIR} ${DZ_DATA_DIR} ${DZ_LOG_DIR} && \
    chown zookeeper:zookeeper ${DZ_DATA_DIR} && \
    chown zookeeper:zookeeper ${DZ_LOG_DIR}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      wget ca-certificates procps && \
    rm -rf /var/lib/apt/lists/*

RUN wget -q https://downloads.apache.org/zookeeper/zookeeper-${DZ_VERSION}/apache-zookeeper-${DZ_VERSION}-bin.tar.gz && \
    tar zxf apache-zookeeper-${DZ_VERSION}-bin.tar.gz -C /opt && \
    rm apache-zookeeper-${DZ_VERSION}-bin.tar.gz && \
    mv /opt/apache-zookeeper-${DZ_VERSION}-bin ${DZ_WORK_DIR} && \
    ln -s ${DZ_WORK_DIR}/conf/log4j.properties ${DZ_CONF_DIR}/log4j.properties

RUN echo ${DZ_MYID} > ${DZ_DATA_DIR}/myid
COPY zoo_example.cfg ${DZ_CONF_DIR}/zoo.cfg
ENV PATH=$PATH:${DZ_WORK_DIR}/bin
WORKDIR ${DZ_WORK_DIR}
EXPOSE 2181/tcp 2888/tcp 3888/tcp 7000/tcp
