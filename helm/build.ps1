# Copyright (c) 2018, Matheson Ventures Pte Ltd
#
# http://mathesonventures.com/
#
# This document is copyright.  You may not reproduce or transmit it any any
# form or by any means without permission in writing from the owner of this
# work, Matheson Ventures Pte Ltd.  If you infringe our copyright, you
# render yourself liable for prosecution.

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
