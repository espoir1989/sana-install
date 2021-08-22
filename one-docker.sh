#!/bin/bash

if [ $USER != 'root' ];then
	echo "请在root下运行!"
	exit
fi

read -p "请输入钱包密码:" password
read -p "请输入面板授权码:" dashboard
echo "####安装基础组件####"
cd /root
apt update 
apt install zip unzip curl wget nginx screen vim -y
echo "####镜像拉取中####"
docker pull expoir1989/sana:v0.1.1
echo "####下载配置文件####"
wget -P /root https://github.com/espoir1989/sana-install/raw/main/ant.yaml
echo "修改配置文件"
sed -i 's/钱包密码/'$password'/' /root/ant.yaml
sed -i 's/test1234/'$dashboard'/' /root/ant.yaml
echo "####启动容器####"
mkdir /home/ant
docker run -d --restart=always -p 1633:1633 -p 1634:1634 -p 1635:1635 -v /root/ant.yaml:/root/ant.yaml -v /home/ant:/home/ant  --name sana expoir1989/sana:v0.1.1 ant start --verbosity 5 --full-node --config /root/ant.yaml --debug-api-enable
echo "####安装面板####"
wget https://github.com/ethsana/exportSanaKey/releases/download/v0.1.0/export-sana-key-linux-amd64
mv export-sana-key-linux-amd64 /usr/bin/ExportKey
chmod -R 777 /usr/bin/ExportKey
wget https://github.com/ethsana/ant-dashboard/archive/refs/heads/online.zip
unzip online.zip
rm -rf /var/www/html/*
cp -r ant-dashboard-online/* /var/www/html/
echo "####启动面板####"
service nginx restart
echo "####查看日志####"
docker logs -f sana
