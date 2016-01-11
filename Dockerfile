FROM ubuntu:14.04
MAINTAINER mimiczo <zhoon80@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
                curl \
                wget \
                git \
                procps \
                net-tools \
                software-properties-common \
                python-software-properties \
        && rm -rf /var/lib/apt/lists/*

# Install Java8.
RUN add-apt-repository ppa:webupd8team/java -y && apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java8-installer
RUN \
  curl http://www.us.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz | tar xz -C /usr/share/ && \
  ln -s /usr/share/apache-maven-3.3.3/bin/mvn /usr/bin/mvn

RUN useradd pinpoint -m
WORKDIR /home/pinpoint

# Set oracle java as the default java
RUN ln -s /usr/lib/jvm/java-8-oracle /usr/lib/jvm/jdk-8-oracle-latest
RUN update-java-alternatives -s java-8-oracle
ENV JAVA_6_HOME /usr/lib/jvm/java-8-oracle
ENV JAVA_7_HOME /usr/lib/jvm/java-8-oracle
ENV JAVA_8_HOME /usr/lib/jvm/java-8-oracle
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV MVN_HOME  /usr/share/apache-maven-3.3.3
ENV PINPOINT_VERSION 1.5.1
ENV HBASE_VERSION 1.0.2

RUN git clone https://github.com/naver/pinpoint.git /pinpoint
WORKDIR /pinpoint
RUN git checkout tags/$PINPOINT_VERSION
RUN mvn install -Dmaven.test.skip=true

WORKDIR quickstart/hbase
ADD http://apache.mirrors.pair.com/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz ./
RUN tar -zxf hbase-$HBASE_VERSION-bin.tar.gz
RUN rm hbase-$HBASE_VERSION-bin.tar.gz
RUN ln -s hbase-$HBASE_VERSION hbase
RUN cp ../conf/hbase/hbase-site.xml hbase-$HBASE_VERSION/conf/
RUN chmod +x hbase-$HBASE_VERSION/bin/start-hbase.sh

WORKDIR /pinpoint
VOLUME [/pinpoint]