#!/bin/bash

# Copyright (c) 2018, Matheson Ventures Pte Ltd
#
# http://mathesonventures.com/
#
# This document is copyright.  You may not reproduce or transmit it any any
# form or by any means without permission in writing from the owner of this
# work, Matheson Ventures Pte Ltd.  If you infringe our copyright, you
# render yourself liable for prosecution.

#
# Produce Dockerfile from Template
#

SETUP="# Imported from setup.sh"

while read p; do
        if [[ -z $p ]] || [[ ${p:0:1} == '#' ]]
        then
                # Skip
                echo Skipping line $p
        else
                SETUP=$SETUP$'\n'"RUN $p"
        fi
done <setup.sh

# Escape characters that will the sed invokation
SETUP="${SETUP//$'\n'/\\n}"     # \n -> \\n
SETUP="${SETUP//\"/\\\"}"       # " -> \"
SETUP="${SETUP//\//\\\/}"       # " -> \"

# Produce the Dockerfile
rm -f Dockerfile
cp Dockerfile.template Dockerfile
sed -i -- "s/SETUP/$SETUP/g" Dockerfile

#
# Build Docker Image
#
prefix=`cat container_prefix`
name=`cat container_name`
containerName=$prefix/$name

sudo docker build -t $containerName .

rm -f Dockerfile
