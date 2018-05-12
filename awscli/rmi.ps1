
$prefix = Get-Content container_prefix
$name = Get-Content container_name
$containerName = "$prefix/$name"

docker rmi $containerName

