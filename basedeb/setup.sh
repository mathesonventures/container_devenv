#!/bin/bash

# basedeb
# Setup for base Debian configuration - primarily installing packages.
#
# Copyright (c) 2018, Matheson Ventures Pte Ltd
#
# http://mathesonventures.com/
#
# This document is copyright.  You may not reproduce or transmit it any any
# form or by any means without permission in writing from the owner of this
# work, Matheson Ventures Pte Ltd.  If you infringe our copyright, you
# render yourself liable for prosecution.

apt-get update; apt-get upgrade; apt-get install -y \
	curl \
	dnsutils \
	git \
	nmap \
	openssh-client \
	python \
	tmux \
	vim \
	wget

