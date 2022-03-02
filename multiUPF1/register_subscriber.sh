#!/bin/bash

curl -XPOST -H 'Content-Type: application/json' -d @subscriber01.json  http://localhost:5000/api/subscriber/imsi-208930000000003/20893
curl -XPOST -H 'Content-Type: application/json' -d @subscriber02.json  http://localhost:5000/api/subscriber/imsi-208930000000004/20893
