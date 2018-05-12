#!/bin/bash

# dockerdeb
# Setup for Docker in Debian.
#
# Copyright (c) 2018, Matheson Ventures Pte Ltd
#
# http://mathesonventures.com/
#
# This document is copyright.  You may not reproduce or transmit it any any
# form or by any means without permission in writing from the owner of this
# work, Matheson Ventures Pte Ltd.  If you infringe our copyright, you
# render yourself liable for prosecution.


apt-get install -y \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg2 \
		software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/debian \
	$(lsb_release -cs) \
	stable"

apt-get update -y; apt-get install -y docker-ce;

