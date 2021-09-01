#!/bin/bash
apt update 
apt install zip unzip curl wget nginx screen vim -y
echo 'github.com 52.74.223.119' >> /etc/hosts
wget https://github.com/ethsana/sana/releases/download/v0.1.2/ant-linux-amd64
wget https://github.com/ethsana/exportSanaKey/releases/download/v0.1.0/export-sana-key-linux-amd64
mv ant-linux-amd64 /usr/bin/ant
mv export-sana-key-linux-amd64 /usr/bin/ExportKey
chmod -R 777 /usr/bin/ant /usr/bin/ExportKey
mkdir /home/ant
wget https://raw.githubusercontent.com/espoir1989/sana-install/main/ant.yaml
wget https://github.com/ethsana/ant-dashboard/archive/refs/heads/online.zip
unzip online.zip
rm -rf /var/www/html/*
cp -r ant-dashboard-online/* /var/www/html/
service nginx restart