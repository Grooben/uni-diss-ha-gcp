# this script configures MySQL servers to a state where replication can be set up, PHPMyAdmin is included for monitoring
#! /bin/bash
FILE=/configd.txt
if [ -f "$FILE"]; then
    echo "Already configured, skipping!"
else
    sudo apt update
    sudo apt -y install apache2 mysql-server nodejs unzip
    sudo chmod -R 0755 /var/www/html/
    sudo systemctl enable apache2
    sudo systemctl start apache2
    mysql -p -e "create user 'dba'@'%' identified by 'project'; grant all privileges on *.* to 'dba'@'%';"
    sudo apt install -y phpmyadmin
    npm install pm2@latest -g
    wget https://github.com/OhGrooben/mysql-rest/archive/master.zip
    unzip master.zip
    sudo touch /configd.txt
fi