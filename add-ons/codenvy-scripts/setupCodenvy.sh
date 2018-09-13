#!/bin/sh
mkdir /tmp/ingest-tools
scp -r /tmp/ingest-tools root@dspace:/
rmdir /tmp/ingest-tools
scp /projects/DSpace-Docker-Images/add-ons/mount_ingest_tools/* root@dspace:/ingest-tools
