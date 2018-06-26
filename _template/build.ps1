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
# Get and filter setup.sh
#

$lineFilter = $("\#.*", "^\s*$")
$lines = (Get-Content ".\setup.sh" | Select-String -Pattern $lineFilter -NotMatch)
$setup = $lines -Join "`r`n"
$setup = $setup -replace "\\`r`n", " "
$lines = $setup -split "`r`n"
$lines = $lines -replace "^", "RUN "
$setup = $lines -Join "`r`n"

#
# Generate Dockerfile
#

$dockerfile = (Get-Content ".\Dockerfile.template") -Join "`r`n"
$dockerfile = $dockerfile.Replace("SETUP", $setup)

Set-Content -Path ".\Dockerfile" $dockerfile

#
# Build Docker Image
#

$prefix = Get-Content container_prefix
$name = Get-Content container_name
$containerName = "$prefix/$name"

docker build -t $containerName .

#
# Clean Up
#

Remove-Item -Path Dockerfile
