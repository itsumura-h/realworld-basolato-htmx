FROM nimlang/nim:2.0.8-ubuntu-regular

# prevent timezone dialogue
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt upgrade -y
RUN apt install -y \
        make \
        libpcre3-dev \
        vim \
        curl \
        git \
        libpq-dev \
        libsass-dev

WORKDIR /project-root
