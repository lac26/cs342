-- Create the Centrepointe church user and database. 
-- See ../README.txt for details.

-- Create the user.
DROP USER lydia CASCADE;
CREATE USER lydia
	IDENTIFIED BY pass
	QUOTA 5M ON System;
GRANT 
	CONNECT,
	CREATE TABLE,
	CREATE SESSION,
	CREATE SEQUENCE,
	CREATE VIEW,
	CREATE MATERIALIZED VIEW,
	CREATE PROCEDURE,
	CREATE TRIGGER,
	UNLIMITED TABLESPACE
	TO system;

-- Connect to the user's account/schema.
CONNECT system/pass;

DROP DIRECTORY exp_dir;
CREATE DIRECTORY exp_dir AS 'C:\Users\lac26\Documents\project';
GRANT READ, WRITE ON DIRECTORY exp_dir to lydia;

-- Create the database.
DEFINE lydia=C:\Users\Lydia\Desktop\cs342\project
@&lydia\load
