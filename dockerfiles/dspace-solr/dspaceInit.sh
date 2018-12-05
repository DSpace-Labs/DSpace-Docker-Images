bin/solr start
bin/solr create -c authority
bin/solr create -c oai
bin/solr create -c search
bin/solr create -c statistics

bin/solr create -c search2
curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"sell-by",
     "type":"pdate",
     "stored":true }
}' http://localhost:8983/solr/search2/schema
bin/solr stop
bin/solr start -f
