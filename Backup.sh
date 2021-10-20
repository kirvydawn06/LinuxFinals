#!/bin/bash

echo "***************************"
echo "* Creating Folder on OPT  *"
echo "***************************"

cd /opt
mkdir backups

echo "Go inside The Folder"

cd /opt/backups

echo "Backups by mysqldump"

mysqldump -u root -p$kirvy wordpress > wordpress_10202021.sql

echo "Compressing File"

tar -zcf wordpress_10202021.tar.gz wordpress_10202021.sql