#!/bin/bash

# awscli
# Setup for AWS CLI in Debian.
#
# Copyright (c) 2018, Matheson Ventures Pte Ltd
#
# http://mathesonventures.com/
#
# This document is copyright.  You may not reproduce or transmit it any any
# form or by any means without permission in writing from the owner of this
# work, Matheson Ventures Pte Ltd.  If you infringe our copyright, you
# render yourself liable for prosecution.

FROM mv/basedeb:latest

CMD ["/bin/bash"]

COPY setup.sh /tmp
RUN /tmp/setup.sh
RUN rm /tmp/setup.sh


wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

pip install awscli --upgrade --user

