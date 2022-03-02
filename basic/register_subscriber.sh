#!/bin/bash

curl -XPOST -H 'Content-Type: application/json' -d @subscriber01.json  http://localhost:5000/api/subscriber/imsi-208930000000003/20893
