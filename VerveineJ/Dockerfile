FROM ubuntu:latest AS base
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        locales \
        curl zip cpio man file \
        ca-certificates git \
        openjdk-17-jdk maven \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

FROM base as image
WORKDIR /opt
RUN git clone https://github.com/moosetechnology/VerveineJ.git
ENV VERVEINEJ_PATH="/opt/VerveineJ"
ENV PATH="${VERVEINEJ_PATH}:${PATH}"
VOLUME /data
WORKDIR /data
ENTRYPOINT verveinej.sh -alllocals -anchor default
