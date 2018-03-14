#!/bin/sh
#http://www.guj.com.br/t/mysql-ssl/290317/5
#https://askubuntu.com/questions/194074/enabling-ssl-in-mysql/439274
set -eux

# Make sure there is an /etc/mysql
mkdir -p /etc/mysql/certs
mkdir -p /etc/mysql/private/certs
mkdir -p /etc/mysql/client
mkdir -p /etc/mysql/private/client

# Copy the local certs to /etc/mysql
cp -ar ca-cert.pem /etc/mysql/client/
cp -ar client-cert.pem /etc/mysql/client/
cp -ar client-key.pem /etc/mysql/private/client/

cp -ar ca-cert.pem /etc/mysql/certs/
cp -ar server-cert.pem /etc/mysql/certs/
cp -ar server-key.pem /etc/mysql/private/certs/

# Put the configs into the server
echo "[client]
ssl-ca=/etc/mysql/client/ca-cert.pem
ssl-cert=/etc/mysql/client/client-cert.pem
ssl-key=/etc/mysql/private/client/client-key.pem

[mysqld]
ssl-ca=/etc/mysql/certs/ca-cert.pem
ssl-cert=/etc/mysql/certs/server-cert.pem
ssl-key=/etc/mysql/private/certs/server-key.pem" >> my.cnf

chown -R mysql.mysql /etc/mysql
/etc/rc.d/rc.mysqld start