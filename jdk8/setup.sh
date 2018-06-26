#!/bin/bash

# Containerized Dev Tools
# Copyright © 2018, Matheson Ventures Pte Ltd
#
# This is free software: you can redistribute it and/or modify it under the
# terms of the GNU General Public License v2 as published by the Free Software
# Foundation.
#
# This software is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this software.  If not, see http://www.gnu.org/licenses/gpl-2.0.html

# Pre-requisites
apt-get update -y; apt-get upgrade -y;

apt-get install -y software-properties-common

add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main"

apt-get update

echo debconf shared/accepted-oracle-license-v1-1 select true | \
  debconf-set-selections

echo debconf shared/accepted-oracle-license-v1-1 seen true | \
  debconf-set-selections

apt-get install -y --allow-unauthenticated oracle-java8-installer
