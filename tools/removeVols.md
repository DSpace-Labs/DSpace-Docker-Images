If you need to manage your Docker volumes, the following scripts may be helpful

Be sure you understand these scripts before running them.

## Removing orphan containers

```
#!/bin/sh
vols=`docker volume ls --format "{{.Labels}};{{.Name}}"|grep -v "com.docker.compose.project"|cut -d';' -f2`

for vol in $vols
do
  docker volume rm $vol
done
```

## Removing volumes associated with a specific dspace version

```
#!/bin/sh
# Set to d4-, d5-, d6-, or d7-
filter=${1:-dX-}
echo "Removing ${filter}"
vols=`docker volume ls --format "{{.Labels}};{{.Name}}"|grep "${filter}"|cut -d';' -f2`

for vol in $vols
do
  docker volume rm $vol
done
```
