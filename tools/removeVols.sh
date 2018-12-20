#!/bin/sh
filter=${1:-random-named}
echo "Removing ${filter}"
if [ "$filter" == "random-named" ]
then
  vols=`docker volume ls --format "{{.Labels}};{{.Name}}"|grep -v "com.docker.compose.project"|cut -d';' -f2`
else
  vols=`docker volume ls --format "{{.Labels}};{{.Name}}"|grep "${filter}"|cut -d';' -f2`
fi
for vol in $vols
do
  docker volume rm $vol
done
