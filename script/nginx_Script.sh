#!/bin/bash

sudo apt update
sudo apt install nginx -y
sudo apt update -y
sudo systemctl enable nginx
sudo systemctl start nginx

sudo apt install php php-mysql php-gd php-cli php-common php-fpm  -y
sudo apt update -y
wget https://wordpress.org/latest.zip
sudo apt install unzip -y
unzip latest.zip

sudo cp -r wordpress/* /var/www/html
cd /etc/nginx/sites-available
sudo chown $USER:$USER default

echo "server {
        listen 80 default_server;
        listen [::]:80 default_server;
root /var/www/html;

        # Add index.php to the list if you are using PHP
        index index.php index.html index.htm index.nginx-debian.html    ;

        server_name _;

        
location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
     }

    location ~ /\.ht {
        deny all;
    }
}" > default

sudo systemctl restart nginx
