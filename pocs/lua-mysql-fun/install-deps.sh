#!/bin/bash

luarocks build --only-deps

sudo apt-get install libmysqlclient-dev -y
sudo apt-get install lua-sql-mysql -y
luarocks install luasql-mysql MYSQL_INCDIR=/usr/include/mysql
