#! /bin/sh

# mysqldump
HOST="127.0.0.1"
USER="root"
PASSWORD="root"

echo "dumping databse sdp dac from server $host ......"

mysqldump -h$HOST -u$USER -p$PASSWORD --databases sdp dac |gzip > /opt/ericsson/sdp/backup/MysqlDB_`date +"%Y-%m-%d"`.sql.gz

echo "database dumping done"