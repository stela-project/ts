#!/bin/sh
if cd "`dirname \"$0\"`"; then
    absdirpath=`pwd`
    cd "$OLDPWD" || exit 1
else
    exit 1
fi
SCRIPTDIR=$absdirpath
BASEDIR=$(dirname $SCRIPTDIR)
SCRIPTNAME=$(basename $0 .sh)

echo ""
echo "===== $SCRIPTNAME ====="
echo ""

echo "install misc dependencies .."
yum install -y vim


## import elastic package key see https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-repositories.html
echo "install elastic package .."
rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch

## elasticsearch

echo "install elastic search .."

echo "
[elasticsearch-6.x]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
" > /etc/yum.repos.d/elasticsearch.repo
yum install -y elasticsearch

systemctl enable elasticsearch.service
systemctl start elasticsearch.service

sleep 15

# elasticsearch config
cp /vagrant_config/files/elkstack/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo /etc/init.d/elasticsearch restart

# logstash

echo "install logstash .."

echo "
[logstash-6.x]
name=Elastic repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
 " > /etc/yum.repos.d/logstash.repo

yum install -y logstash

systemctl enable logstash.service
systemctl start logstash.service


sleep 15

## apache
echo "configure apache .."
cp /vagrant_config/files/apache/app.conf /etc/httpd/conf.d/vhost.conf.d/app.conf

echo "create database.."
su - postgres -c 'createuser stela'
su - postgres -c 'createdb -O stela stela'

## app setup
echo "install and configure apache .."

cp /vagrant_config/files/app/config.php /home/vagrant/public_html/application/config/config.php

chown -R vagrant:vagrant /home/vagrant/public_html


## restart services
echo "restart services .."
systemctl restart php-fpm
systemctl restart httpd
