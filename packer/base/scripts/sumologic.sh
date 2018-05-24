#!/bin/bash
set -e

# Download the sumo collector executable
sudo wget 'https://collectors.us2.sumologic.com/rest/download/linux/64' -O SumoCollector.sh && \
    sudo chmod +x SumoCollector.sh

access_id=$(credstash -r us-east-1 get sumologic.access_id)
access_key=$(credstash -r us-east-1 get sumologic.access_key)

sudo ./SumoCollector.sh -q \
    -VskipRegistration=true \
    -Vephemeral=true \
    -Vsumo.accessid=$access_id \
    -Vsumo.accesskey=$access_key