#!/bin/bash

sudo apt update

sudo apt install nginx -y
sudo apt update
sudo systemctl enable nginx
sudo systemctl start nginx

sudo apt install php php-mysql php-gd php-cli php-common php-fpm  -y

sudo wget https://wordpress.org/latest.zip
sudo apt install unzip -y
sudo unzip latest.zip

sudo cp -r wordpress/* /var/www/html
sudo systemctl restart nginx
