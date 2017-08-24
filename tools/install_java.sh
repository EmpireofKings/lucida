#!/bin/bash
apt-get install openjdk-8-jdk openjdk-8-jre
echo JAVA_HOME=`find /usr/lib/jvm/ -mindepth 1 -maxdepth 1 -type d | head -1` >> /etc/environment
