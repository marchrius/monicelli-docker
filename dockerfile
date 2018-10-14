FROM ubuntu:14.04

MAINTAINER Matteo <<Marchrius>> Gaggiano <developer@marchrius.org>

RUN apt-get update

RUN apt-get install -y wget

RUN echo "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.5 main" > /etc/apt/sources.list.d/llvm.org.list
RUN echo "deb-src http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.5 main" >> /etc/apt/sources.list.d/llvm.org.list

RUN wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | apt-key add -

RUN apt-get update

RUN apt-get install -y --force-yes llvm-3.5-dev

RUN apt-get install -y bison flex libboost-all-dev libyaml-cpp-dev g++ cmake libedit-dev git-core

RUN ln -s /usr/share /usr/lib/llvm-3.5/share
RUN ln -s /usr/share/llvm-3.5 /usr/share/llvm

RUN mkdir -p /opt/monicelli

RUN git clone https://github.com/esseks/monicelli.git /opt/monicelli

RUN mkdir -p /opt/monicelli/build

CMD cd /opt/monicelli/build && cmake .. && make install
