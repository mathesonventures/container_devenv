#!/bin/bash

cd basedeb
./build.sh
cd ..

cd jdk8
./build.sh
cd ..

cd nodejs8
./build.sh
cd ..

cd nodejs10
./build.sh
cd ..

cd dockerdeb
./build.sh
cd ..

cd awscli
./build.sh
cd ..

cd k8s
./build.sh
cd ..

cd terraform
./build.sh
cd ..

cd jekyll
./build.sh
cd ..
