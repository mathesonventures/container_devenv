#!/bin/bash

prefix=`cat container_prefix`
name=`cat container_name`
containerName=$prefix/$name
instanceName=$name-prod

sudo docker run -it --rm \
	--name $instanceName \
	--mount source=wrk,target=/dat/wrk \
	--mount source=awscli,target=/root/.aws \
	-v /var/run/docker.sock:/var/run/docker.sock \
	$containerName

