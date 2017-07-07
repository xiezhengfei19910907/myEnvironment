#!/bin/bash

# update source and install compile tools
sudo apt-get update
sudo apt-get install -y build-essential

# cache
sudo apt-get install -y memcached redis

# php
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get install -y php5.6 php5.6-bcmath php5.6-cli php5.6-dba php5.6-fpm php5.6-imap php5.6-json php5.6-mcrypt 
sudo apt-get install -y php5.6-opcache php5.6-sybase php5.6-xmlrpc php5.6-bz2 php5.6-common php5.6-dev php5.6-gd php5.6-interbase 
sudo apt-get install -y php5.6-ldap php5.6-mysql php5.6-pgsql php5.6-readline php5.6-soap php5.6-tidy php5.6-xsl php5.6-cgi
sudo apt-get install -y php5.6-curl php5.6-enchant php5.6-gmp php5.6-intl php5.6-mbstring php5.6-odbc php5.6-phpdbg 
sudo apt-get install -y php5.6-recode php5.6-xml php5.6-xdebug php5.6-zip php5.6-msgpack php5.6-redis php5.6-gearman

# composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/bin
sudo ln -s -f /usr/bin/composer.phar /usr/bin/composer

# install other tools
sudo apt-get install -y libxml2-dev libbz2-dev libgmp-dev libmcrypt-dev libreadline-dev libxslt-dev libmemcached-dev libcurl4-gnutls-dev
sudo apt-get install -y pkg-config
sudo apt-get install -y libpcre3 libpcre3-dev
sudo ln -s -f /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h
sudo apt-get install -y libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev
sudo apt-get install -y lrzsz
sudo apt-get install -y vim
sudo apt-get install -y curl wget
sudo apt-get install -y ssh openssh-client openssh-server
sudo apt-get install -y dos2unix
sudo apt-get install -y libcairo2-dev libjpeg8-dev libpango1.0-dev libgif-dev g++

# nginx
sudo apt-get install -y nginx
sudo cp /opt/ifchange.conf /etc/nginx/sites-enabled/

# git
sudo apt-get install -y git
sudo git config --global http.sslVerify false

# project config (be)
sudo rm -rf /opt/wwwroot/tob/web/be/config/development/common.config.php 
sudo cp /opt/wwwroot/tob/web/be/config/development/common.config.php.sample /opt/wwwroot/tob/web/be/config/development/common.config.php
sudo rm -rf /opt/wwwroot/tob/web/be/config/log4php_.properties
sudo cp /opt/wwwroot/tob/web/be/config/log4php_.properties.sample /opt/wwwroot/tob/web/be/config/log4php_.properties

cd /opt/php_token_crypt_nocert
sudo phpize5.6 && sudo ./configure && sudo make && sudo make install
sudo echo "extension=token_crypt.so" > ~/token_crypt.ini
sudo cp ~/token_crypt.ini /etc/php/5.6/mods-available/
sudo ln -s /etc/php/5.6/mods-available/token_crypt.ini /etc/php/5.6/fpm/conf.d/20-token_crypt.ini
sudo ln -s /etc/php/5.6/mods-available/token_crypt.ini /etc/php/5.6/cli/conf.d/20-token_crypt.ini

# project config (fe)
sudo rm -rf /opt/wwwroot/tob/web/fe/config/local.js
sudo echo "module.exports = {
  assetsDomain: ['http://img.dev.ifchange.com/'],
  domain: 'http://dev.tob.ifchange.com',
  port: 2521
};" | sudo tee /opt/wwwroot/tob/web/fe/config/local.js

# restart service
sudo service nginx restart
sudo service php5.6-fpm restart