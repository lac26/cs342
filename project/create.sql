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
	TO lydia;

-- Connect to the user's account/schema.
CONNECT lydia/pass;


-- Create the database.
DEFINE lydia=S:\cs342\project
@&lydia\load
