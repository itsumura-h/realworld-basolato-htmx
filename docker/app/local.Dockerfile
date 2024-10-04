FROM ubuntu:24.04

# prevent timezone dialogue
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt upgrade -y
RUN apt install -y \
        gcc \
        xz-utils \
        ca-certificates \
        libpcre3-dev \
        vim \
        curl \
        git \
        libpq-dev

# gcc... for Nim
# xz-utils... for unzip tar.xz
# ca-certificates... for https
# libpcre3-dev... for nim regex

ARG NIM_VERSION="2.0.0"
WORKDIR /root
RUN curl -OL https://nim-lang.org/choosenim/init.sh 
RUN sh init.sh -y
RUN rm -f init.sh
ENV PATH $PATH:/root/.nimble/bin
RUN choosenim ${NIM_VERSION}

# nimlangserver
WORKDIR /root
RUN curl -o nimlangserver.tar.gz -L https://github.com/nim-lang/langserver/releases/download/v1.6.0/nimlangserver-1.6.0-linux-amd64.tar.gz
RUN tar -zxvf nimlangserver.tar.gz
RUN rm -f nimlangserver.tar.gz
RUN mv nimlangserver /root/.nimble/bin/

RUN git config --global --add safe.directory /root/project

WORKDIR /root/project
