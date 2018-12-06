#!/bin/bash
bin/solr start
bin/solr create -c authority
curl -X POST -H 'Content-type:application/json' -d '@/tmp/authority-schema.json' http://localhost:8983/solr/authority/schema
bin/solr create -c oai
curl -X POST -H 'Content-type:application/json' -d '@/tmp/oai-schema.json' http://localhost:8983/solr/oai/schema
bin/solr create -c search
curl -X POST -H 'Content-type:application/json' -d '@/tmp/search-schema.json' http://localhost:8983/solr/search/schema
bin/solr create -c statistics
curl -X POST -H 'Content-type:application/json' -d '@/tmp/statistics-schema.json' http://localhost:8983/solr/statistics/schema
bin/solr stop
bin/solr start -f
