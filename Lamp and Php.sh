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
