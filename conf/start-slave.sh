#!/bin/sh

while ! mysqladmin ping -h mysql --silent; do
  sleep 1
done

mysql -u root -h mysql -e "RESET MASTER;"
mysql -u root -h mysql -e "FLUSH TABLES WITH READ LOCK;"

mysqldump -uroot -h mysql --all-databases --master-data --single-transaction --flush-logs --events > /tmp/master_dump.sql

mysql -u root -e "STOP SLAVE;";
mysql -u root < /tmp/master_dump.sql

log_file=`mysql -u root -h mysql -e "SHOW MASTER STATUS\G" | grep File: | awk '{print $2}'`
pos=`mysql -u root -h mysql -e "SHOW MASTER STATUS\G" | grep Position: | awk '{print $2}'`

mysql -u root -e "RESET SLAVE";
mysql -u root -e "CHANGE MASTER TO MASTER_HOST='mysql', MASTER_USER='root', MASTER_PASSWORD='', MASTER_LOG_FILE='${log_file}', MASTER_LOG_POS=${pos};"
mysql -u root -e "start slave"

mysql -u root -h mysql -e "UNLOCK TABLES;"
