1)  check out /opt/ericsson/sdp/setup-tool/builds/config/mysql/bin/backup.sh from svn, change host/user/password if needed

2)  install cron job, change file path if needed
		crontab -e 
		30 23 * * * /opt/ericsson/sdp/setup-tool/builds/config/mysql/bin/backup.sh 2>&1>> /opt/ericsson/sdp/backup/Mysql_back.log
		
3) 	restart cron job
		/etc/init.d/crond restart		

4)  run below command to restore database, change host/user/password/database/file path if needed
		mysql -h127.0.0.1 -uroot -proot sdp < MysqlDB_2012-05-09.sql 2>&1>> Mysql_restore.log
		mysql -h127.0.0.1 -uroot -proot dac < MysqlDB_2012-05-09.sql 2>&1>> Mysql_restore.log
