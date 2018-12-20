#!/bin/sh
cd /dspace-src/dspace/target/dspace-installer
ant update clean_backups
catalina.sh run
