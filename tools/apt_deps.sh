#!/bin/bash
## Installs all package manager dependencies

apt-get update
apt-get install -y g++ \
                   gcc \
                   build-essential \
                   libc6 \
                   libssl-dev \
                   libsasl2-dev \
                   pkg-config \
                   git \
                   curl \
                   libevent-dev \
                   libboost-all-dev \
                   python-all-dev \
                   curl \
                   openjdk-8-jdk \
                   openjdk-8-jre \
                   python-pip \
                   python-gobject-2 \
                   python-gobject \
                   python-gi \
                   python-yaml \
                   scons \
                   python-numpy \
                   libprotoc-dev \
                   ant \
                   bison \
                   flex \
                   php \
                   phpunit \
                   libglib2.0-dev \
                   libtbb-dev \
                   libavresample-dev \
                   libeigen3-dev \
                   apache2 \
                   libapache2-mod-php \
                   libgstreamer-plugins-good1.0-dev \
                   libgstreamer-plugins-bad1.0-dev \
                   gstreamer1.0-tools \
                   gstreamer1.0-plugins-good \
                   gstreamer1.0-plugins-bad \
                   gstreamer1.0-plugins-ugly \
                   libgstreamer1.0-dev \
                   perl \
                   autoconf \
                   automake \
                   libtool \
                   python-ws4py \
                   python-virtualenv \
                   libclass-accessor-perl \
                   libbit-vector-perl \
                   libjansson-dev \
                   ffmpeg
