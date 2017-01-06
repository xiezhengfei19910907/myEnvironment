#!/bin/bash

sudo apt-get update
sudo apt-get install -y build-essential

sudo apt-get install -y memcached node.js npm
sudo apt-get install -y php php7.0-cli php7.0-cgi php7.0-fpm php7.0-mcrypt php7.0-mysql
sudo apt-get install -y php-mcrypt php-memcached php-curl php-gmp php-mysql php-xdebug php-mbstring php-gd php-soap php-imap

sudo ln -s -f /usr/bin/nodejs /usr/bin/node
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/bin
sudo ln -s -f /usr/bin/composer.phar /usr/bin/composer

sudo apt-get install -y libxml2-dev libbz2-dev libgmp-dev libmcrypt-dev libreadline-dev libxslt-dev libmemcached-dev libcurl4-gnutls-dev
sudo apt-get install -y pkg-config
sudo apt-get install -y libpcre3 libpcre3-dev
sudo ln -s -f /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h
sudo apt-get install -y libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev

sudo apt-get install -y nginx
sudo mkdir -p /var/nginxproxycache/client_temp
sudo cp -r /var/www/nginx_config/* /etc/nginx/

sudo apt-get install -y lrzsz vim git dos2unix
sudo git config --global http.sslVerify false

echo 'zend_extension=xdebug.so
xdebug.remote_enable = 1
xdebug.remote_connect_back = 1
xdebug.remote_port = 9000
xdebug.scream=0
xdebug.cli_color=1
xdebug.show_local_vars=1
xdebug.idekey="PHPSTORM"' > /etc/php/7.0/mods-available/xdebug.ini

sudo service php7.0-fpm restart
sudo service nginx restart

#sudo mkdir /root/.ssh
#sudo cp -r /var/www/test_rsa /root/.ssh/
#sudo chmod -R 600 /root/.ssh/test_rsa