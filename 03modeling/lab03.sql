-- Starter code for lab 3.
--
-- CS 342, Spring, 2017
-- kvlinden


drop table Person_Team;
drop table Team;
drop table Mentor;
drop table Request;
drop table Person;
drop table HouseHold;
drop table HomeGroup;



create table HouseHold(
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);
	
create table HomeGroup (
	ID integer PRIMARY KEY,
	name varchar(100)
);


create table Team( 
	ID integer PRIMARY KEY,
	name varchar(30)
);


	-- on DELETE CASCADE because person must always be part of household
create table Person (
	ID integer PRIMARY KEY,
	houseID integer NOT NULL,
	homeGroupID integer,
	title varchar(4),
	firstName varchar(15),
	lastName varchar(15),
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c')),
	role varchar(30),
	Foreign Key (houseID) REFERENCES HouseHold(ID) ON DELETE CASCADE,
	Foreign Key (homeGroupID) REFERENCES HomeGroup(ID) ON DELETE SET NULL
	);
	
	
	/* I originally had mentor ID in the person table, however this made it difficult to drop the person table to I made it separate.  Another benefit is not so many NULL values */
create table Mentor (
	menteeID integer,
	mentorID integer,
	Foreign Key (mentorID) REFERENCES Person(ID) ON DELETE SET NULL,
	Foreign Key (menteeID) REFERENCES Person(ID) ON DELETE SET NULL
);



create table Person_Team(
	TeamID integer,
	PersonID integer,
	role varchar(30),
	dateJoined date,
	durationMonths integer,	
	Primary Key (TeamID, PersonID),
	Foreign Key (TeamID) REFERENCES Team(ID) ON DELETE SET NULL,
	Foreign Key (PersonID) REFERENCES Person(ID) ON DELETE SET NULL
);

/* since is weak entity type has identifying relationship with household */
create table Request(
	requestDate date,
	requestText varchar(400),
	requestAccess varchar(1),
	requestResponse varchar(400),
	requestorID integer,
	respondorID integer,
	Primary Key (requestDate, requestorID),
	Foreign Key (requestorID) REFERENCES Household(ID) ON DELETE CASCADE,
	Foreign Key (respondorID) REFERENCES Person(ID) ON DELETE SET NULL		
);




INSERT INTO Household VALUES (0,'2347 Oxford Dr. SE','Grand Rapids','MI','49506','616-243-5680');
INSERT INTO Household VALUES (1,'Burton Street','Grand Rapids','MI','49546','616-551-5680');

INSERT INTO HomeGroup VALUES (1, 'the VanderLinden gathering');
INSERT INTO HomeGroup VALUES (2, 'Beka Fan Club');

INSERT INTO Person VALUES (0, 0, 1, 'mr.','Keith','VanderLinden','m', 'father');
INSERT INTO Person VALUES (1, 0, 1, 'ms.','Brenda','VanderLinden','m', 'mother');
INSERT INTO Person VALUES (2, 0, 2, 'ms.','Beka','Agava','m', 'child');
INSERT INTO Person VALUES (3, 1, 2, 'ms.','Lydia','Cupery','m', 'child');

INSERT INTO Mentor VALUES (2, 0);

INSERT INTO Team VALUES (1, 'worhip team');
INSERT INTO Team VALUES (2, 'elders');
INSERT INTO Team VALUES (3, 'website admin');

INSERT INTO Person_Team VALUES (3, 0, 'system admin', '01-Mar-2015', 30);
INSERT INTO Person_Team VALUES (3, 2, 'hacker', '01-Mar-2015', 90);
INSERT INTO Person_Team VALUES (3, 1, 'elder', '01-Mar-2015', 20);

INSERT INTO Request VALUES ('05-Feb-2017', 'I need a higher IQ', 'A', 'I will pray for your IQ', 1, 2);
INSERT INTO Request VALUES ('10-Feb-2017', 'please pray for the snow to stop!', 'A', 'no, I like the snow!', 1, 0);





/* please see model_lab03 for the diagram */


