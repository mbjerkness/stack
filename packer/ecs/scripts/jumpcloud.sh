#!/bin/bash
set -e

sudo service jcagent stop
sleep 5
sudo rm -f /opt/jc/ca.crt /opt/jc/client.crt /opt/jc/client.key /opt/jc/jcagent.conf
