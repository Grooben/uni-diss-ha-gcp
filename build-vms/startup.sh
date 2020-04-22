# this script configures MySQL servers to a state where replication can be set up, PHPMyAdmin is included for monitoring
#! /bin/bash
FILE=/configd.txt
if [ -f "$FILE"]; then
    echo "Already configured, skipping!"
else
    sudo apt update
    curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
    sudo apt -y install apache2 mysql-server unzip git nodejs
    sudo chmod -R 0755 /var/www/html/
    sudo systemctl enable apache2
    sudo systemctl start apache2
    sudo touch /configd.txt
    mysql -p -e "create user 'dba'@'%' identified WITH mysql_native_password by 'project'; grant all privileges on *.* to 'dba'@'%';"
    sudo add-apt-repository ppa:phpmyadmin/ppa
    # sudo apt install -y phpmyadmin - disabled due to manual configuration required
    npm install pm2@latest -g
    git clone https://github.com/OhGrooben/mysql-rest.git
    
fi