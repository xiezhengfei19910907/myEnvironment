#!/bin/bash

sudo apt-get update
sudo apt-get install -y build-essential

sudo apt-get install -y memcached
sudo apt-get install -y node.js
sudo apt-get install -y npm
sudo apt-get install -y php5-cli php5-cgi php5-fpm php5-mcrypt php5-mysql php5-memcached php5-curl php5-gmp php5-xcache

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

sudo apt-get install -y php5-dev php-pear
sudo pecl install xdebug swoole
sudo apt-get install -y lrzsz
sudo apt-get install -y vim

sudo apt-get install -y git
sudo git config --global http.sslVerify false

cd /var/www/prometheus/
sudo rm -rf composer.lock
sudo composer  install  --no-dev  -vv

sudo echo "<?php
\$GLOBALS['DOMAIN'] = 'JJsHouse';
\$serve_host = '__SERVER_NAME__';
\$stage = 'dev-1';
" | sudo tee /var/www/prometheus/data/env_config.php

cd /var/www/prometheus/src/
sudo npm install
sudo node node_modules/gulp/bin/gulp.js --theme=lisa

cd /var/www/prometheus/
sudo php bin/lang_pack.php

sudo service nginx restart
sudo service php5-fpm restart

sudo cp -r /var/www/test_rsa /root/.ssh/
sudo chmod -R 600 /root/.ssh/test_rsa