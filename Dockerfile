FROM centos
MAINTAINER LuanVU<vuluanbg@gmail.com>

RUN yum –y update

#Install wget
RUN yum install -y wget

#Install Java 10.0.2
RUN wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/10.0.2+13/19aef61b38124481863b1413dce1855f/jdk-10.0.2_linux-x64_bin.rpm

RUN yum localinstall jdk-10.0.2_linux-x64_bin.rpm

#Install sbt
RUN wget https://dl.bintray.com/sbt/rpm/sbt-1.2.1.rpm
RUN yum localinstall sbt-1.2.1.rpm

#Install git
RUN yum install -y git

RUN git config --global user.name "Luan VU"
RUN git config --global user.email "vuluanbg@gmail.com"

WORKDIR /root
RUN mkdir -p /root/.ssh
COPY keys .ssh
RUN git clone git@gitlab.com:spowermedia/sdoc.git

COPY start.sh /venv

RUN chmod a+x /venv/*

ENTRYPOINT ["/venv/start.sh"]

EXPOSE 9000