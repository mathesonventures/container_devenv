#!/bin/bash

cd basedeb
./build.sh
cd ..

cd jdk8
./build.sh
cd ..

cd dockerdeb
./build.sh
cd ..

cd awscli
./build.sh
cd ..

cd kops
./build.sh
cd ..

