#!/usr/bin/env sh

echo "Installing dependecies"
apt update
apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    ca-certificates \
    cmake \
    git \
    make \
    tar \
    libssl-dev \
    libsasl2-dev \
    pkg-config \
    libsystemd-dev \
    zlib1g-dev \
    libpq-dev \
    postgresql-server-dev-all \
    systemd \
    flex \
    bison

TAG=${GITHUB_REF##*/}
echo "Cloning fluent bit code"
git clone https://github.com/fluent/fluent-bit.git
cd fluent-bit
git checkout ${TAG:=v1.9.5}
cd build

echo "Building from source"
cmake -DFLB_RELEASE=On \
    -DFLB_TRACE=Off \
    -DFLB_JEMALLOC=On \
    -DFLB_TLS=On \
    -DFLB_SHARED_LIB=On \
    -DFLB_EXAMPLES=Off \
    -DFLB_HTTP_SERVER=On \
    -DFLB_CONFIG_YAML=Off ..

make

