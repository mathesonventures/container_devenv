#!/bin/bash

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

