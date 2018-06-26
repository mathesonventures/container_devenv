#!/bin/bash

# Copyright (c) 2018, Matheson Ventures Pte Ltd
#
# http://mathesonventures.com/
#
# This document is copyright.  You may not reproduce or transmit it any any
# form or by any means without permission in writing from the owner of this
# work, Matheson Ventures Pte Ltd.  If you infringe our copyright, you
# render yourself liable for prosecution.

prefix=`cat container_prefix`
name=`cat container_name`
containerName=$prefix/$name

sudo docker rmi $containerName
