#!/bin/bash

# Tutorial
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-lamp-amazon-linux-2.html

# Step 1: Prepare the LAMP server
sudo yum update -y
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum install -y httpd mariadb-server

# Start the Apache web server.
sudo systemctl start httpd

# Use the systemctl command to configure the Apache web server to start at each system boot.
sudo systemctl enable httpd

# To set file permissions
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;

rm /var/www/html/phpinfo.php

# Step 3: Secure the database server
sudo systemctl start mariadb
sudo systemctl enable mariadb

# For production, run:
# sudo mysql_secure_installation
