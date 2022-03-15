#!/bin/bash

sudo apt update

sudo apt-get install openjdk-8-jdk -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins -y
sudo systemctl restart jenkins 
sudo apt install git


# ELK kibana 5601
sudo apt install kibana -y
sudo systemctl enable kibana
sudo systemctl start kibana

## GRAFANA 3000
sudo wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
sudo apt-get update -y
sudo apt-get install grafana -y
sudo systemctl enable grafana-server
sudo systemctl start grafana-server


