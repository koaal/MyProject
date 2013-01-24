SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS sys_user_permission
;
DROP TABLE IF EXISTS sys_user
;


CREATE TABLE sys_user_permission
(
	user_id BIGINT NOT NULL,
	node VARCHAR(50) NOT NULL,
	action VARCHAR(50) NOT NULL,
	instance VARCHAR(50) NOT NULL,
	INDEX idx_permission_user_id (user_id ASC)
) ENGINE=InnoDB
;


CREATE TABLE sys_user
(
	id BIGINT NOT NULL,
	name VARCHAR(50) NOT NULL,
	password VARCHAR(50) NOT NULL,
	role VARCHAR(50) NOT NULL,
	email VARCHAR(50),
	mobile VARCHAR(50),
	department VARCHAR(50),
	address VARCHAR(255),
	status VARCHAR(50) DEFAULT 'active',
	deleted TINYINT DEFAULT 0,
	description VARCHAR(255),
	PRIMARY KEY (id),
	INDEX idx_sys_user_name (name ASC)
) ENGINE=InnoDB
;


ALTER TABLE sys_user_permission ADD CONSTRAINT FK_permission_user 
	FOREIGN KEY (user_id) REFERENCES sys_user (id)
;

SET FOREIGN_KEY_CHECKS=1;
