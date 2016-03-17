#!/bin/bash

sudo apt-get update
sudo apt-get install -y build-essential

sudo apt-get install -y memcached
sudo apt-get install -y node.js
sudo apt-get install -y npm
sudo apt-get install -y php5-cli php5-cgi php5-fpm php5-mcrypt php5-mysql php5-memcached  php5-curl php5-gmp

sudo ln -s -f /usr/bin/nodejs /usr/bin/node
sudo bash -c "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin"
sudo ln -s -f /usr/bin/composer.phar /usr/bin/composer

sudo apt-get install -y libxml2-dev libbz2-dev libgmp-dev libmcrypt-dev libreadline-dev libxslt-dev libmemcached-dev libcurl4-gnutls-dev
sudo apt-get install -y pkg-config
sudo apt-get install -y libpcre3 libpcre3-dev
sudo ln -s -f /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h
sudo apt-get install -y  libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev

cd /tmp
wget http://nginx.org/download/nginx-1.8.0.tar.gz
tar xzvf nginx-1.8.0.tar.gz
cd nginx-1.8.0
./configure \
    --prefix=/usr/share/nginx                                                                                                                   \
    --sbin-path=/usr/sbin/nginx                                                                                                                 \
    --conf-path=/etc/nginx/nginx.conf                                                                                                           \
    --error-log-path=/var/log/nginx/error.log                                                                                                   \
    --http-log-path=/var/log/nginx/access.log                                                                                                   \
    --http-client-body-temp-path=/var/lib/nginx/tmp/client_body                                                                                 \
    --http-proxy-temp-path=/var/lib/nginx/tmp/proxy                                                                                             \
    --http-fastcgi-temp-path=/var/lib/nginx/tmp/fastcgi                                                                                         \
    --http-uwsgi-temp-path=/var/lib/nginx/tmp/uwsgi                                                                                             \
    --http-scgi-temp-path=/var/lib/nginx/tmp/scgi                                                                                               \
    --pid-path=/var/run/nginx.pid                                                                                                               \
    --lock-path=/var/lock/subsys/nginx                                                                                                          \
    --user=nginx                                                                                                                                \
    --group=nginx                                                                                                                               \
    --with-file-aio                                                                                                                             \
    --with-ipv6                                                                                                                                 \
    --with-http_ssl_module                                                                                                                      \
    --with-http_spdy_module                                                                                                                     \
    --with-http_realip_module                                                                                                                   \
    --with-http_addition_module                                                                                                                 \
    --with-http_xslt_module                                                                                                                     \
    --with-http_image_filter_module                                                                                                             \
    --with-http_geoip_module                                                                                                                    \
    --with-http_sub_module                                                                                                                      \
    --with-http_dav_module                                                                                                                      \
    --with-http_flv_module                                                                                                                      \
    --with-http_mp4_module                                                                                                                      \
    --with-http_gunzip_module                                                                                                                   \
    --with-http_gzip_static_module                                                                                                              \
    --with-http_random_index_module                                                                                                             \
    --with-http_secure_link_module                                                                                                              \
    --with-http_degradation_module                                                                                                              \
    --with-http_stub_status_module                                                                                                              \
    --with-http_perl_module                                                                                                                     \
    --with-mail                                                                                                                                 \
    --with-mail_ssl_module                                                                                                                      \
    --with-pcre                                                                                                                                 \
    --with-google_perftools_module                                                                                                              \
    --with-debug                                                                                                                                \
    --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic'     \
    --with-ld-opt=' -Wl,-E'

sudo make && make install
sudo mkdir -p /var/lib/nginx/tmp/client_body
sudo mkdir -p /var/nginxproxycache/client_temp

sudo cp -r /var/www/nginx_config/* /etc/nginx
sudo cp /var/www/nginx /etc/init.d
sudo update-rc.d nginx defaults

sudo groupadd -r nginx
sudo useradd -r -g nginx -s /bin/false -M nginx

sudo groupadd -r www-data
sudo useradd -r -g www-data -s /bin/false -M www-data

sudo apt-get install php5-dev php-pear
sudo pecl install xdebug
sudo apt-get install -y lrzsz
sudo apt-get install -y vim

sudo apt-get install -y git
sudo git config --global http.sslVerify false

cd /var/www/prometheus/
sudo rm composer.lock
sudo composer  install  --no-dev  -vv

sudo echo "<?php
\$GLOBALS['DOMAIN'] = 'JJsHouse';
\$serve_host = '__SERVER_NAME__';
\$stage = 'dev-1';
" | sudo tee /var/www/prometheus/data/env_config.php

cd /var/www/prometheus/src/
sudo npm install
sudo node node_modules/gulp/bin/gulp.js --theme=hera

cd /var/www/prometheus/
sudo php bin/lang_pack.php -d"JJsHouse" -l"en de es fr se no it pt da fi ru nl ja"

cd /var/www/prometheus/src/php/webapp/
for lang in en de es fr se no it pt da fi ru nl ja; do sudo  ln -s . $lang; done;

sudo apt-get install dos2unix
sudo apt-get install unix2dos
sudo dos2unix /etc/init.d/nginx
sudo systemctl daemon-reload

sudo service nginx restart
sudo service php5-fpm restart