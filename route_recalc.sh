#!/bin/bash

MADmin_username_1=USER
MADmin_password_1=PASS
MAD_url_1=http://localhost:5000

curl -s -u $MADmin_username_1:$MADmin_password_1 -H 'X-Beautify: 1' '$MAD_url_1/api/area?hide_resource=1&mode=pokestops'|grep -Po 'area\/\K[^"]*' > pokestops_areas.txt

while IFS= read -r line; do
curl -s -u $MADmin_username_1:$MADmin_password_1 -H 'Content-Type: application/json-rpc' -d '{"call": "recalculate"}' $MAD_url_1/api/area/$line
    echo "Recalculating pokestops area ID: $line"
done < pokestops_areas.txt

rm pokestops_areas.txt
