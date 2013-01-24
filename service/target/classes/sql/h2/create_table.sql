DROP TABLE IF EXISTS sys_user_permission
;
DROP TABLE IF EXISTS sys_user
;

CREATE TABLE sys_user_permission
(
	user_id BIGINT NOT NULL,
	node VARCHAR(50) NOT NULL,
	action VARCHAR(50) NOT NULL,
	instance VARCHAR(50) NOT NULL
) 
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
	PRIMARY KEY (id)
) 
;
