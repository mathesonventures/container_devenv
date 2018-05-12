
$prefix = Get-Content container_prefix
$name = Get-Content container_name
$containerName = "$prefix/$name"
$instanceName = "$($name)-prod"

docker run -it --rm `
	--name $instanceName `
	--mount source=wrk,target=/dat/wrk `
	--mount source=awscli,target=/root/.aws `
	-v /var/run/docker.sock:/var/run/docker.sock `
	$containerName

