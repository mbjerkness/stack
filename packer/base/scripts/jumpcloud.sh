#!/bin/bash
set -e

connect_key=$(credstash -r us-east-1 get jumpcloud.connect_key)
curl --silent --show-error --header "x-connect-key: $connect_key" https://kickstart.jumpcloud.com/Kickstart | sudo bash
sleep 5
sudo service jcagent stop
sleep 5
sudo rm -f /opt/jc/ca.crt /opt/jc/client.crt /opt/jc/client.key /opt/jc/jcagent.conf
