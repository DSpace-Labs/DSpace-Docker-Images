#!/bin/bash
set -e

# -v ON_ERROR_STOP=1 ?

psql -f ../database_schema.sql --username "$POSTGRES_USER"
