#!/bin/bash

# Compile and Install jansson
curl -sf -o jansson.tar.gz -L http://www.digip.org/jansson/releases/jansson-2.7.tar.gz
mkdir jansson
tar -xzf jansson.tar.gz -C jansson --strip-components=1
rm jansson.tar.gz
cd jansson
autoreconf -i
./configure
make
make install
rm -r /usr/src/jansson
