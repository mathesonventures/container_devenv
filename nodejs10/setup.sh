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

# The installation steps in this script are adapted from the documenation at
# https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions

# Pre-requisites
apt-get update -y; apt-get upgrade -y;

apt-get install -y \
	curl \
	gnupg2

curl -sL https://deb.nodesource.com/setup_10.x | bash -

apt-get install -y nodejs
