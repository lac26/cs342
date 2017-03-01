-- This command file loads an experimental person relation.
-- The data conforms to the following assumptions:
--     * Person IDs and team IDs are unique for people and teams respectively.
--     * People can have at most one mentor.
--     * People can be on many teams, but only have one role per team.
--     * Teams meet at only one time.
--
-- CS 342
-- Spring, 2017
-- kvlinden

drop table AltPerson;
drop table Person_Team;
drop table Person;
drop table Team;

CREATE TABLE AltPerson (
	personId integer,
	name varchar(10),
	status char(1),
	mentorId integer,
	mentorName varchar(10),
	mentorStatus char(1),
    teamName varchar(10),
    teamRole varchar(10),
    teamTime varchar(10)
	);

INSERT INTO AltPerson VALUES (0, 'Ramez', 'v', 1, 'Shamkant', 'm', 'elders', 'trainee', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'elders', 'chair', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'executive', 'protem', 'Wednesday');
INSERT INTO AltPerson VALUES (4, 'Shamkant', 'm', NULL, NULL, NULL, 'executive', 'protem', 'Wednesday');
INSERT INTO AltPerson VALUES (2, 'Jennifer', 'v', 3, 'Jeff', 'm', 'deacons', 'treasurer', 'Tuesday');
INSERT INTO AltPerson VALUES (3, 'Jeff', 'm', NULL, NULL, NULL, 'deacons', 'chair', 'Tuesday');


/* c */ 


CREATE TABLE Person(
	personID integer PRIMARY KEY,
	name varchar (10),
	status char(1),
	mentorID integer,
	Foreign Key (mentorID) REFERENCES Person(personID) ON DELETE SET NULL
);

CREATE TABLE Team(
	teamName varchar(10) PRIMARY KEY,
	teamTime varchar (10)
);

CREATE TABLE Person_Team(
	personID integer,
	teamName varchar(10),
	teamRole varchar(10),
	Primary Key (personID, teamName),
	Foreign Key (personID) REFERENCES Person(personID) ON DELETE CASCADE,
	Foreign key (teamName) REFERENCES Team(teamName) ON DELETE CASCADE
);

INSERT INTO Person SELECT DISTINCT PersonID, name, status, mentorID FROM AltPerson;
INSERT INTO Team SELECT DISTINCT teamName, teamTime FROM AltPerson;
INSERT INTO Person_Team SELECT DISTINCT personID, teamName, teamRole FROM AltPerson;

SELECT * FROM Person;
SELECT * FROM Team;
SELECT * FROM Person_Team;

SELECT personID from Person;
SELECT teamName from Team;
SELECT personID, teamName from Person_Team;

/* Exercise 4.1 
Why it is not well-designed (informally): 
Person can only have one mentor
There are multiple entries for Shamkant.  He has two entries because he is part of two different teams.  
The information that elders meet on Monday and deacons meet on Tuesday is repeated every time a new memeber is added to that team.  
There are NULL values whenever there is not a mentee for mentorStatus and mentorName.
The relationship can not be described consisely, i.e. this is not just a person relation or a team relation, it is some mix between the two.
Team name might not be unique, what if there was 2 teams of elders meeting at different times?

 Why it is not well-designed(formally):
 Functional dependencies:
 personID -> name, status, mentorID, mentorName, mentorStatus
 mentorID -> mentorName, mentorStatus
 teamName -> teamTime
 personID, teamName -> teamRole
 
 
Candidate keys:
 personID, teamName
 
 
 Given the person ID, we know the status of the member and who the mentor is.
 Given the mentorID, we know the mentorName and mentorStatus.
 And, given the teamName, we know when the team meets.
 And, when we know both the personID and the teamName, we know the teamRole.
 Thus the above are all functional dependencies.  
 However, neither personID nor mentorID nor teamName is a superkey
 Because personID, mentorID and teamName are not superkeys this is not BCNF.  
 There is redundancy here because of repeated information.
 
 
 Properly normalized schema for DB:
 Person(personID, name, status, mentorID) where personID is a PK, mentorID is a FK to Person
 Person_Team(personID, teamID, teamRole)
 Team(teamID, teamName, teamTime)
 

*/