-- Create the Centrepointe church user and database. 
-- See ../README.txt for details.

-- Create the user.
DROP USER bookDB CASCADE;
CREATE USER bookDB
	IDENTIFIED BY bjarne
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
	TO bookDB;

DROP DIRECTORY exp_dir;
CREATE DIRECTORY exp_dir AS 'C:\Users\lac26\Documents\project';
GRANT READ, WRITE ON DIRECTORY exp_dir to bookDB;

