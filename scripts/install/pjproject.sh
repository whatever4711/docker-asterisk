#!/bin/bash

# Compile and install pjproject
curl -sf -o pjproject.tar.bz2 -L http://www.pjsip.org/release/2.4/pjproject-2.4.tar.bz2
tar -xjvf pjproject.tar.bz2
rm -f pjproject.tar.bz2
cd pjproject-2.4
CFLAGS='-DPJ_HAS_IPV6=1' ./configure --enable-shared --disable-sound --disable-resample --disable-video --disable-opencore-amr
make dep
make
make install
rm -r /usr/src/pjproject-2.4
