#!/bin/bash
# Clean up script

rm -rf opencv
rm -rf thrift-*
rm -rf fbthrift
rm -rf mongo-c-driver
rm -rf mongo-cxx-driver

for tar in *.tar.gz;
do
  if [ -f "$tar" ]; then
    rm "$tar"
  fi
done
