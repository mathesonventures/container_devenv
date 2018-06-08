# Dev Tools

## Introduction

This project packages up a the following common dev tools so that they can be easily used in a portable and hassle-free fashion:

- JDK8
- NodeJS 8
- NodeJS 10
- AWS CLI
- Kubernetes Operations - kops

The primary vehicle for delivering these dev tools is Docker - each tools is packaged as a Docker image that can be run almost anywhere.  Additionally the setup scripts for each tool can be applied to other compatible base environments.

## About

### Project

The public home of this project is https://github.com/mathesonventures/devtools.

### License

This project is offered to you under the terms of the GNU GPLv2 free software license.  Please refer to the file LICENSE in the root of the repository or see https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html for the license terms.  Your use of this project indicates your acceptance of the terms of the GNU GPLv2 license.

## Quick Start

You can use the tools bundled in this project in three easy steps: Clone; Build; Run;

```
# Clone
$ git clone https://github.com/mathesonventures/devtools.git
$ cd devtools

# Build
$ ./buildall.sh  # Will take a few minutes as it builds all tools in the project

# Run
$ cd jdk8        # Or one of the other tools
$ ./run.sh
```

This will bring you into a container running interactively where you can now use the tool - for example using javac from JDK8

```
root@1696754a76f7:/# javac -version
javac 1.8.0_171
root@1696754a76f7:/#
```

## Project Structure

Each tool is separated into its own directory, and for each tool you'll find the following:

- setup.sh - the setup script which implements the actual work of preparing dependencies and deploying the tool
- Dockerfile.template - the Docker shell for setup.sh that produces a Docker image for the tool.
- Lifecycle scripts - a set of bash and equivalent Powershell scripts for driving the container
  - **build** - Builds the Docker image
  - **rmi** - Removes the Docker image
  - **run** - Runs a new Docker container interactively
- container_prefix and container_name - metadata used by the Lifecycle scripts

Note that the build script will generate the Dockerfile from Dockerfile.template with the setup.sh inlined into it as a series of RUN directives.  This approach allows Docker's layer mechanism to work properly: the image will be comprised of a layer for each command in setup.sh instead of just a single layer for running setup.sh

## Running Dev Tools via Docker

### Image Dependency Overview

The images defined in this project have dependencies that you need to follow when building up the images from scratch.  Read this table from left to right to follow the dependencies:

| L1      | L2        | L3     | L4   |
| ------- | --------- | ------ | ---- |
| basedeb | jdk8      |        |      |
|         | nodejs8   |        |      |
|         | nodejs10  |        |      |
|         | dockerdeb | awscli | kops |

### basedeb

The `basedeb` tool is just the library/debian image from Docker Hub with a number of commonly required dev tools installed - specifically:

- curl
- dnsutils
- git
- nmap
- openssh-client
- tmux
- vim
- wget

Example build:

```
cd basedeb
./build.sh

Sending build context to Docker daemon  17.92kB
Step 1/3 : FROM debian:8.8
 ---> 62a932a5c143

...

Successfully tagged mv/devtools/basedeb:latest
```

Example run:

```
cd basedeb
./run.sh

root@171591a0f56f:/# whoami
root
```

### jdk8

The `jdk8` Docker image is based on `basedeb` and adds into it the Oracle Java JDK8 package, installed from the package maintained by webupd8team on Launchpad.

Example build:

```
cd jdk8
./build.sh

Sending build context to Docker daemon  18.94kB
Step 1/7 : FROM mv/devtools/basedeb:latest
 ---> 3bf9651e1386

...

Successfully tagged mv/devtools/jdk8:latest
```

Example run:

```
cd jdk8
./run.sh

root@35dfcfc7a3a2:/# javac -version
javac 1.8.0_171
root@35dfcfc7a3a2:/# java -version
java version "1.8.0_171"
Java(TM) SE Runtime Environment (build 1.8.0_171-b11)
Java HotSpot(TM) 64-Bit Server VM (build 25.171-b11, mixed mode)
```

### nodejs8

The `nodejs8` Docker images is based on `basedeb` and adds into it the NodeJS package including npm.

Example build:

```
cd nodejs8
./build.sh

Sending build context to Docker daemon   16.9kB
Step 1/4 : FROM mv/devtools/basedeb:latest

...

Successfully tagged mv/devtools/nodejs8:latest
```

Example run:

```
cd nodejs8
./run.sh

root@500780e8fc42:/# npm -version
5.6.0
```

### nodejs10

The `nodejs10` Docker images is based on `basedeb` and adds into it the NodeJS package including npm.

Example build:

```
cd nodejs10
./build.sh

Sending build context to Docker daemon   16.9kB
Step 1/4 : FROM mv/devtools/basedeb:latest

...

Successfully tagged mv/devtools/nodejs10:latest
```

Example run:

```
cd nodejs10
./run.sh

root@29dda0bdb27c:/# npm -version
6.1.0
```

### dockerdeb

The `dockerdeb` Docker image is based on `basedeb` and installs the Docker tools into the image.

The run script for this tool mounts the host's Docker socket into the container so that Docker within the container is actually interacting with the Docker daemon running on the host.  The motivating for having a containerized Docker is so that tools dependent on Docker - such as kops - can also be containerized.  You probably won't find yourself using `dockerdeb` as it doesn't add anything over just running Docker commands on your dev workstation directly.

Example build:

```
cd dockerdeb
./build.sh

Sending build context to Docker daemon  18.43kB
Step 1/5 : FROM mv/devtools/basedeb:latest
 ---> 3bf9651e1386

...

Successfully tagged mv/devtools/dockerdeb:latest
```

Example run:

```
cd dockerdeb
./run.sh

root@8b2035593f39:/# docker version
Client:
 Version:      18.03.1-ce
 API version:  1.37
 Go version:   go1.9.5
 Git commit:   9ee9f40
 Built:        Thu Apr 26 07:16:02 2018
 OS/Arch:      linux/amd64
 Experimental: false
 Orchestrator: swarm

Server:
 Engine:
  Version:      18.03.1-ce
  API version:  1.37 (minimum version 1.12)
  Go version:   go1.9.5
  Git commit:   9ee9f40
  Built:        Thu Apr 26 07:14:13 2018
  OS/Arch:      linux/amd64
  Experimental: false
```

### awscli

The `awscli` Docker image is based on `dockerdeb` and adds the AWS CLI tool.

Note that at the moment this image is based on `dockerdeb` even though you don't necessarily need Docker when using AWS CLI.  This is because the `kops` tool requires both the `dockerdeb` layers and the `awscli` layers.  In the future we will improve this with a composition-based approach to building images to replace the linear dependency model currently in place.

Example build:

```
cd awscli
./build.sh

Sending build context to Docker daemon  17.92kB
Step 1/6 : FROM mv/devtools/dockerdeb:latest
 ---> dea06b3c4039

...

Successfully tagged mv/devtools/awscli:latest
```

Example run:

```
cd awscli
./run.sh

root@837402c57c6f:/# aws configure
AWS Access Key ID: WFKERFJSDFIWERFDSJF
AWS Secret Access Key: 17c1edac1d4f430c8a57a4f395e7e35e
Default region name: ap-southeast-1
Default output format [None]:
```

### kops

The `kops` Docker image is based on `awscli` and adds the Kubernetes Operations (kops) tool.

Example build:

```
cd kops
./build.sh

Sending build context to Docker daemon  18.43kB
Step 1/5 : FROM mv/devtools/awscli:latest
 ---> c3289c111758

...

Successfully tagged mv/devtools/kops:latest
```

Example run:

```
cd kops
./run.sh

root@6db6fff6219b:/# kops version
Version 1.9.1 (git-ba77c9ca2)
```

