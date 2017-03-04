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


CREATE TABLE Person (
	ID integer PRIMARY KEY,
	firstName varchar(20),
	lastName varchar(20),
	userName varchar(20),
	password varchar(20),
	bpoints integer
	);

CREATE TABLE Condition(
	ID integer PRIMARY KEY,
	description varchar(30)
);	
	/* could make sep. type & cond. table to limit values */
CREATE TABLE Book(
	ID integer PRIMARY KEY,
	author varchar (100),
	title varchar (100),
	edition integer,
	conditionID integer,
	Foreign Key (conditionID) REFERENCES Condition(ID) ON DELETE SET NULL
);

CREATE TABLE Collection(
	ID integer PRIMARY KEY,
	name varchar (60)
);

CREATE TABLE BookCollection(
	bookID integer,
	collectionID integer,
	Primary Key (bookID, collectionID),
	Foreign Key (bookID) REFERENCES Book(ID) ON DELETE CASCADE,
	Foreign Key (collectionID) REFERENCES Collection(ID) ON DELETE CASCADE	
);

CREATE TABLE ShareGroup(
	ID integer PRIMARY KEY,
	name varchar (60)	
);

CREATE TABLE CollectionGroup(
	collectionID integer,
	groupID integer,
	Primary key(collectionID, groupID),
	Foreign Key (collectionID) REFERENCES Collection(ID) ON DELETE CASCADE,
	Foreign Key (groupID) REFERENCES ShareGroup(ID) ON DELETE CASCADE
);

Create TABLE PersonGroup (
	personID integer,
	groupID integer,
	Primary Key (personID, groupID),
	Foreign Key (personID) REFERENCES Person(ID) ON DELETE CASCADE,
	Foreign Key (groupID) REFERENCES ShareGroup(ID) ON DELETE CASCADE
);

CREATE TABLE BookGroup (
	bookID integer,
	groupID integer,
	Primary Key(bookID, groupID),
	Foreign Key (bookID) REFERENCES Book(ID) ON DELETE CASCADE,
	Foreign Key (groupID) REFERENCES ShareGroup(ID) ON DELETE CASCADE
);


CREATE TABLE PersonBook(
	bookID integer,
	ownerID integer,
	quant integer,
	Primary Key (bookID, ownerID),
	Foreign Key (bookID) REFERENCES Book(ID) ON DELETE CASCADE,
	Foreign Key (ownerID) REFERENCES Person(ID) ON DELETE CASCADE
);

CREATE TABLE LoanBook(
	bookID integer,
	borrowerID integer,
	loanerID integer,
	loanDate date,
	loanWeeks integer,
	Primary Key(bookID,borrowerID, loanerID),
	Foreign Key(bookID) REFERENCES Book(ID) ON DELETE CASCADE,
	Foreign Key(borrowerID) REFERENCES Person(ID) ON DELETE SET NULL,
	Foreign Key(loanerID) REFERENCES Person(ID) ON DELETE SET NULL
);


CREATE SEQUENCE seq_person START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_book START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_coll START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_group START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_cond START WITH 1 INCREMENT BY 1;







