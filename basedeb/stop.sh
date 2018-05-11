#!/bin/bash

prefix=`cat container_prefix`
name=`cat container_name`
containerName=$prefix/$name
instanceName=$name-prod

sudo docker stop $instanceName
sudo docker rm $instanceName

