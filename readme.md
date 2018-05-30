# Dev Tools

## Introduction

The idea behind this project is to package up some common dev tools so that they can be easily used in a portable and hassle-free fashion.

The primary vehicle for delivering these dev tools is Docker - each tools is packaged as a Docker image that can be run almost anywhere.

Additionally the scripts for setting up each tool can be run on other compatible base environments.

The deployment of each tools is a separate and independent layer which can be composed with other layers to form a complete environment.  The Docker images defined by this project set a specific order to the assembly of the layers, but you could easily compose them in a different order to get exactly the toolset you need.

## License

This project is offered to you under the terms of the GNU GPLv2 free software license.  Please refer to the file LICENSE in the root of the repository or see https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html for the license terms.  Your use of this project indicates your acceptance of the terms of the GNU GPLv2 license.

## Project

The public home of this project is https://github.com/mathesonventures/devtools.

## Standard Structure

Each tool is separated into its own directory, and for each tool you'll find the following:

- setup.sh - the setup script which implements the actual work of preparing dependencies and deploying the tool
- Dockerfile - the Docker wrapper for setup.sh that produces a Docker image for the tool
- Lifecycle scripts - a set of bash and equivalent Powershell scripts for driving the container
  - build
  - launch
  - remove
  - rmi
  - run
  - stop
- container_prefix and container_name - metadata used by the Lifecycle scripts

## Docker Images

The tool layers defined in this repo are independent - for example if you need a Docker image that has awscli and kops you could compose them in either order:

```
awscli + kops = myimage
kops + cli = myimage
```

And end up at the same point.

This repo provides Docker images structured in what is in our opinion, the most logical order.  These will probably suit you just fine but again if you prefer a different composition you can easily create it.  Each image builds on the one before it:

- basedeb - Debian with some base tools
- dockerdeb - Docker cli with the host Docker socket mounted
- awscli - Deploys the AWS CLI
- kops - The Kubernets Operations (kops) tool

