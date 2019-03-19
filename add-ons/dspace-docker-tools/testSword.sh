#!/bin/sh

cd /tmp

curl -o example.zip https://github.com/DSpace/DSpace/blob/dspace-5_x/dspace-sword/example/example.zip

curl -i --data-binary "@example.zip" -H "Content-Disposition:filename=example.zip" -H "Content-Type:application/zip" -H "X-Packaging:http://purl.org/net/sword-types/METSDSpaceSIP" -u test@test.edu:admin http://localhost:8080/sword/deposit/123456789/4

curl -i --data-binary "@example.zip" -H "Content-Disposition:attachment; filename=example.zip" -H "Content-Type:application/zip" -H "Packaging:http://purl.org/net/sword/package/METSDSpaceSIP" -u test@test.edu:admin -X POST http://localhost:8080/swordv2/collection/123456789/3
