#!/usr/bin/env bash
#http://www.guj.com.br/t/mysql-ssl/290317/5
set -eux

# Make sure there is an /etc/mysql
mkdir -p /etc/mysql/certs
mkdir -p /etc/mysql/private/certs
mkdir -p /etc/mysql/client
mkdir -p /etc/mysql/private/client

chown -R mysql.mysql /etc/mysql

# Create CA certificate
openssl genrsa 2048 > ca-key.pem
openssl req -new -x509 -nodes -days 1000 -key ca-key.pem > ca-cert.pem

# Create server certificate
openssl req -newkey rsa:2048 -days 1000 -nodes -keyout server-key.pem > server-req.pem

openssl x509 -req -in server-req.pem -days 1000 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 > server-cert.pem

# Create client certificate
openssl req -newkey rsa:2048 -days 1000 -nodes -keyout client-key.pem > client-req.pem

openssl x509 -req -in client-req.pem -days 1000 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 > client-cert.pem

# Wherever MySQL configs live, go there (this is for cross-platform)
cd $(my_print_defaults --help | grep my.cnf | xargs find 2>/dev/null | xargs dirname)

# Copy the local certs to /etc/mysql
cp -ar ca-cert.pem /etc/mysql/client/
cp -ar client-cert.pem /etc/mysql/client/
cp -ar client-key.pem /etc/mysql/private/client/

cp -ar ca-cert.pem /etc/mysql/certs/
cp -ar server-cert.pem /etc/mysql/certs/
cp -ar server-key.pem /etc/mysql/private/certs/

# Put the configs into the server
echo "
[client]
ssl-ca=/etc/mysql/client/ca-cert.pem
ssl-cert=/etc/mysql/client/client-cert.pem
ssl-key=/etc/mysql/private/client/client-key.pem

[mysqld]
ssl-ca=/etc/mysql/certs/ca-cert.pem
ssl-cert=/etc/mysql/certs/server-cert.pem
ssl-key=/etc/mysql/private/certs/server-key.pem
" >> my.cnf
