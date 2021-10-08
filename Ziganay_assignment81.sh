#!/bin/bash

echo "Install httpd"
yum install -y httpd

echo "Start httpd"
systemctl start httpd.service

echo "Adding firewall rules"
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp

echo "Reload firewall"
firewall-cmd ––reload
echo "End of installation#"

echo "Install PHP"
yum install -y php php-mysql

echo "restart httpd"
systemctl restart httpd.service

echo "Instal PHP-FPM"
yum install -y php-fpm 

echo "<?php phpinfo(); ?>" > /var/www/html/info.php
echo "End of PHP installaion"




echo "install mysql"
yum install -y mariadb-server mariadb-server

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

echo "enable mariadb"
systemctl enable mariadb.service
echo "testing the installation"

mysqladmin -u root -p version
echo "root"

echo "END OF LAMP INSTALLATION"

