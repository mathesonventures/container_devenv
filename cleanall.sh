#!/bin/bash

cd terraform
./rmi.sh
cd ..

cd helm
./rmi.sh
cd ..

cd kops
./rmi.sh
cd ..

cd awscli
./rmi.sh
cd ..

cd dockerdeb
./rmi.sh
cd ..

cd nodejs10
./rmi.sh
cd ..

cd nodejs8
./rmi.sh
cd ..

cd jdk8
./rmi.sh
cd ..

cd basedeb
./rmi.sh
cd ..
