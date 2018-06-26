#!/bin/bash

# Copyright (c) 2018, Matheson Ventures Pte Ltd
#
# http://mathesonventures.com/
#
# This document is copyright.  You may not reproduce or transmit it any any
# form or by any means without permission in writing from the owner of this
# work, Matheson Ventures Pte Ltd.  If you infringe our copyright, you
# render yourself liable for prosecution.

# Pre-requisites
#echo 'Acquire::http { Proxy "http://192.168.2.5:3142"; }' >> /etc/apt/apt.conf.d/proxy; \

apt-get update -y; apt-get upgrade -y;

apt-get install -y \
	wget;


wget https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz

tar xvzf helm-v2.9.1-linux-amd64.tar.gz

mv linux-amd64/helm /usr/local/bin
rm -Rf linux-amd64
rm helm-v2.9.1-linux-amd64.tar.gz

