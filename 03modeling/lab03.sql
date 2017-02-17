-- Starter code for lab 3.
--
-- CS 342, Spring, 2017
-- kvlinden


drop table Person_Team2;
drop table Team2;
drop table Mentor2;
drop table Person2;
drop table HouseHold2;
drop table HomeGroup2;



create table HouseHold2(
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);
	
create table HomeGroup2 (
	ID integer PRIMARY KEY,
	name varchar(100)
);

/* 2 */
create table Team2( 
	ID integer PRIMARY KEY,
	name varchar(30),
	role varchar(30),
	dateJoined date,
	durationDays integer	
);

/* 3 */
	-- on DELETE CASCADE because person must always be part of household
create table Person2 (
	ID integer PRIMARY KEY,
	houseID integer NOT NULL,
	homeGroupID integer,
	title varchar(4),
	firstName varchar(15),
	lastName varchar(15),
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c')),
	role varchar(30),
	Foreign Key (houseID) REFERENCES HouseHold2(ID) ON DELETE CASCADE,
	Foreign Key (homeGroupID) REFERENCES HomeGroup2(ID) ON DELETE SET NULL
	);
	
	/* 4 */
	/* I originally had mentor ID in the person table, however this made it difficult to drop the person table to I made it separate.  Another benefit is not so many NULL values */
create table Mentor2 (
	menteeID integer,
	mentorID integer,
	Foreign Key (mentorID) REFERENCES Person2(ID) ON DELETE SET NULL,
	Foreign Key (menteeID) REFERENCES Person2(ID) ON DELETE SET NULL
);

/* 1 */

create table Person_Team2(
	TeamID integer,
	PersonID integer,
	role varchar(30),
	Primary Key (TeamID, PersonID),
	Foreign Key (TeamID) REFERENCES Team2(ID) ON DELETE SET NULL,
	Foreign Key (PersonID) REFERENCES Person2(ID) ON DELETE SET NULL
);

		




INSERT INTO Household2 VALUES (0,'2347 Oxford Dr. SE','Grand Rapids','MI','49506','616-243-5680');
INSERT INTO Household2 VALUES (1,'Burton Street','Grand Rapids','MI','49546','616-551-5680');

INSERT INTO HomeGroup2 VALUES (1, 'the VanderLinden gathering');
INSERT INTO HomeGroup2 VALUES (2, 'Beka Fan Club');

INSERT INTO Person2 VALUES (0, 0, 1, 'mr.','Keith','VanderLinden','m', 'father');
INSERT INTO Person2 VALUES (1, 0, 1, 'ms.','Brenda','VanderLinden','m', 'mother');
INSERT INTO Person2 VALUES (2, 0, 2, 'ms.','Beka','Agava','m', 'child');

INSERT INTO Mentor2 VALUES (2, 0);

/* please see model_lab03 for the diagram */


