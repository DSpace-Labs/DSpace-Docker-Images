#!/bin/sh

BR=${BASEROOT:-http://localhost:8080}
# Run this in /add-ons/sword from your desktop - not within Docker

curl -i --data-binary "@example.zip" -H "Content-Disposition:filename=example.zip" -H "Content-Type:application/zip" -H "X-Packaging:http://purl.org/net/sword-types/METSDSpaceSIP" -u test@test.edu:admin -X POST ${BR}/sword/deposit/123456789/4

curl -i --data-binary "@example.zip" -H "Content-Disposition:attachment; filename=example.zip" -H "Content-Type:application/zip" -H "Packaging:http://purl.org/net/sword/package/METSDSpaceSIP" -u test@test.edu:admin -X POST ${BR}/swordv2/collection/123456789/3
