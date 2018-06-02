#!/bin/bash

apt-get update

apt-get install -y software-properties-common

add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main"

apt-get update

echo debconf shared/accepted-oracle-license-v1-1 select true | \
  debconf-set-selections

echo debconf shared/accepted-oracle-license-v1-1 seen true | \
  debconf-set-selections

apt-get install -y --allow-unauthenticated oracle-java8-installer

