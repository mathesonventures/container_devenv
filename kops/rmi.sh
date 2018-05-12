#!/bin/bash

prefix=`cat container_prefix`
name=`cat container_name`
containerName=$prefix/$name

sudo docker rmi $containerName

