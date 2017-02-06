#FROM resin/rpi-raspbian:jessie
FROM resin/rpi-node:6.5-slim

#Uncommend this if building on Raspi
ADD qemu-arm-static /usr/bin/qemu-arm-static

RUN apt-get update \ 
    && apt-get -y install wget \
    git libgnutls28-dev libgnutlsxx28 libudev-dev build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /build \
    && cd /build \
    && git clone https://github.com/OpenZWave/open-zwave.git \
    && cd open-zwave \
    && rm -rf .git \
    && make \
    && make install

RUN cd /build \
    && wget ftp://ftp.gnu.org/gnu/libmicrohttpd/libmicrohttpd-0.9.52.tar.gz \
    && tar zxvf libmicrohttpd-0.9.52.tar.gz \
    && rm libmicrohttpd-0.9.52.tar.gz \
    && mv libmicrohttpd-0.9.52 libmicrohttpd \
    && cd libmicrohttpd \
    && ./configure \
    && make \
    && make install

RUN cd /build \
    && git clone https://github.com/OpenZWave/open-zwave-control-panel.git \
    && cd open-zwave-control-panel \
    && rm -rf .git/

ADD files/ozcp/Makefile /build/open-zwave-control-panel

RUN cd /build/open-zwave-control-panel \
    && make \
    && ln -sd ../open-zwave/config

ADD files/microhttp.conf /etc/ld.so.conf.d/
RUN ldconfig

WORKDIR /build/open-zwave-control-panel

CMD ["./ozwcp","-p", "8888"]
