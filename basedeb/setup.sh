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
#echo 'Acquire::http { Proxy "http://192.168.2.5:3142"; }' >> /etc/apt/apt.conf.d/proxy; \
	apt-get update -y; \
	apt-get upgrade -y;

apt-get install -y \
	curl \
	dnsutils \
	git \
	locales \
	mosh \
	nmap \
	openssh-client \
	tmux \
	vim \
	wget

echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8
