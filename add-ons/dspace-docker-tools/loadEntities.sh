#!/bin/sh
# Once this file has been saved to a docker volume, the ingest step will not be re-run
psql -U dspace < /tmp/dspace.sql
