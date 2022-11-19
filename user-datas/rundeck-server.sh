#!/bin/bash

curl https://raw.githubusercontent.com/rundeck/packaging/main/scripts/rpm-setup.sh 2> /dev/null | bash -s rundeck

sudo yum install -y java-11-openjdk
sudo yum install -y rundeck
sudo systemctl start rundeckd
sudo systemctl enable rundeckd
