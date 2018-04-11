FROM ubuntu:16.04

WORKDIR /build

RUN apt-get update
RUN apt-get install -y wget
RUN wget "http://sigrok.org/download/source/libserialport/libserialport-0.1.1.tar.gz"
RUN wget "http://sigrok.org/download/source/libsigrok/libsigrok-0.5.0.tar.gz"
RUN wget "http://sigrok.org/download/source/libsigrokdecode/libsigrokdecode-0.5.0.tar.gz"
RUN wget "http://sigrok.org/download/source/sigrok-cli/sigrok-cli-0.7.0.tar.gz"
RUN wget "http://sigrok.org/download/source/pulseview/pulseview-0.4.0.tar.gz"
RUN wget "http://sigrok.org/download/source/sigrok-dumps/sigrok-dumps-0.1.0.tar.gz"
RUN wget "http://sigrok.org/download/source/sigrok-firmware-fx2lafw/sigrok-firmware-fx2lafw-0.1.6.tar.gz"
RUN wget "http://sigrok.org/download/binary/sigrok-firmware-fx2lafw/sigrok-firmware-fx2lafw-bin-0.1.6.tar.gz"

RUN apt-get install -y \
    build-essential file libzip-dev libglib2.0-dev python3-dev \
    git-core g++ make cmake libtool pkg-config \
    libglib2.0-dev libboost-test-dev libboost-serialization-dev \
    libboost-filesystem-dev libboost-system-dev libqt5svg5-dev qtbase5-dev \
    libglibmm-2.4-dev autoconf autoconf-archive libusb-1.0-0-dev \
    libftdi1-dev check doxygen python3-numpy

RUN mkdir -p /dist

# === libserialport ===
WORKDIR /build
RUN tar xzvf libserialport-0.1.1.tar.gz
WORKDIR /build/libserialport-0.1.1
RUN ./configure --prefix=/usr
RUN make
RUN make install
RUN make DESTDIR=/dist install

# === libsigrok ===
WORKDIR /build
RUN tar xzvf libsigrok-0.5.0.tar.gz
WORKDIR /build/libsigrok-0.5.0
RUN ./configure --prefix=/usr
RUN make
RUN make install
RUN make DESTDIR=/dist install

# === libsigrokdecode ===
WORKDIR /build
RUN tar xzvf libsigrokdecode-0.5.0.tar.gz
WORKDIR /build/libsigrokdecode-0.5.0
RUN ./configure --prefix=/usr
RUN make
RUN make install
RUN make DESTDIR=/dist install

# === sigrok-cli ===
WORKDIR /build
RUN tar xzvf sigrok-cli-0.7.0.tar.gz
WORKDIR /build/sigrok-cli-0.7.0
RUN ./configure --prefix=/usr
RUN make
RUN make install
RUN make DESTDIR=/dist install

# === pulseview ===
WORKDIR /build
RUN tar xzvf pulseview-0.4.0.tar.gz
WORKDIR /build/pulseview-0.4.0
RUN cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr .
RUN make
RUN make install
RUN make DESTDIR=/dist install
