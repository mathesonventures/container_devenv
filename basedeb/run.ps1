
$prefix = Get-Content container_prefix
$name = Get-Content container_name
$containerName = "$prefix/$name"
$instanceName = "$($name)-prod"

docker run -it `
	--name $instanceName `
	$containerName

