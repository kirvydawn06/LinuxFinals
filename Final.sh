#!/bin/bash

echo "**********************"
echo "*  Start The Script  *"
echo "**********************"

echo "**********************"
echo "*  Installing httpd  *"
echo "**********************"
yum install -y httpd

echo "Start httpd"
systemctl start httpd.service

echo "Adding firewall rules"
firewall-cmd --add-port 80/tcp --permanent
firewall-cmd --add-port 443/tcp --permanent

echo "Reload firewall"
firewall-cmd --reload

echo "Enable httpd"
systemctl enable httpd.service
echo "*******************************"
echo "*  End of httpd installation  *"
echo "*******************************"

echo "********************"
echo "*  Installing Php  *"
echo "********************"
yum install -y php php-mysql

echo "restart httpd"
systemctl restart httpd.service
yum info-php-fpm

echo "Instal PHP-FPM"
yum install -y php-fpm 
cd /var/www/html

cat > info.php <<- EOF
<?php phpinfo(); ?>
EOF
echo "*****************************"
echo "*  End of Php installation  *"
echo "*****************************"

echo "************************"
echo "*  Installing MariaDB  *"
echo "************************"
yum install -y mariadb-server mariadb

echo "start mariadb"
systemctl start mariadb

mysql_secure_installation << EOF

Y
root
root
Y
Y
Y
Y
EOF

kirvy=root
echo "enable mariadb"
systemctl enable mariadb
mysqladmin -u root -p$kirvy version

echo "testing the installation"

echo "*********************************"
echo "*  End of MariaDB installation  *"
echo "*********************************"

echo "************************"
echo "*  Creating WordPress  *"
echo "************************"

echo "CREATE DATABASE wordpress; CREATE USER 
wordpressuser@localhost IDENTIFIED by 'paulyupogi'; GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED by 'root'; FLUSH PRIVILEGES; "| mysql -u root -p$kirvy

echo "installing Php-gd"
yum install php-gd -y

echo "installing tar"
yum install -y tar

echo "installing wget"
yum install wget -y

systemctl restart httpd

echo "installing WP from website"
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz

echo "installing rsync"
yum install -y rsync

rsync -avP wordpress/ /var/www/html/
cd /var/www/html/
mkdir /var/www/html/wp-content/uploads
chown -R apache:apache /var/www/html/*

echo "configuring WP"
cp wp-config-sample.php wp-config.php
cd /var/www/html/

sed -i 's/database_name_here/wordpress/g' wp-config.php
sed -i 's/username_here/wordpressuser/g' wp-config.php
sed -i 's/password_here/root/g' wp-config.php


yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm 
yum install -y yum-utils
yum-config-manager --enable remi-php56 
yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo 

echo "restart httpd"
systemctl restart httpd
echo "***********************************"
echo "*  End of WordPress installation  *"
echo "***********************************"

