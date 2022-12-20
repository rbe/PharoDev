FROM ubuntu:latest AS base
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y  --no-install-recommends \
        locales \
        curl zip cpio man file \
        ca-certificates git \
        ninja-build cmake make g++ libxml2 libxml2-dev libboost-all-dev libarchive-dev libssl-dev libcurl4-openssl-dev libxslt1-dev antlr libantlr-dev \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

FROM base AS builder
RUN mkdir /build
RUN cd /build \
    && git clone https://github.com/srcML/srcML \
    && cd srcML \
    && git checkout develop \
    && sed -i'' -e '/#include <cstring>/a#include <algorithm>' src/parser/UTF8CharBuffer.cpp \
    && mkdir build \
    && cd build \
    && cmake -DBUILD_CLIENT_TESTS=OFF -DBUILD_LIBSRCML_TESTS=OFF -DBUILD_PARSER_TESTS=OFF .. \
    && make -j $(nproc) \
    && make -j $(nproc) install \
    && ldconfig
RUN cd /build \
    && git clone --recursive https://github.com/srcML/srcUML.git \
    && cd srcUML \
    && mkdir srcuml_build \
    && cd srcuml_build \
    && cmake .. \
    && make -j$(nproc) \
    && make -j$(nproc) install \
    && cp bin/srcuml /usr/local/bin

FROM base AS image
COPY --from=builder /usr/local /usr/local
RUN ldconfig
WORKDIR /data
