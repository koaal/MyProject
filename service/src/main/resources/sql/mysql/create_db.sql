CREATE DATABASE IF NOT EXISTS `myproject` character set utf8;
GRANT ALL PRIVILEGES ON myproject.* TO myproject@`%`  IDENTIFIED BY 'myproject';
GRANT ALL PRIVILEGES ON myproject.* TO myproject@`localhost` IDENTIFIED BY 'myproject';

FLUSH PRIVILEGES;



