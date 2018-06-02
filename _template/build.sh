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

