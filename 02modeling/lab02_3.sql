-- This command file loads a simple movies database, dropping any existing tables
-- with the same names, rebuilding the schema and loading the data fresh.
--
-- CS 342, Spring, 2015
-- kvlinden

-- Drop current database

DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Performer;
DROP TABLE Status;

DROP SEQUENCE seq_movie;


-- Create database schema
CREATE TABLE Movie (
	id integer,
	title varchar(70) NOT NULL, 
	year decimal(4), 
	score float,
	PRIMARY KEY (id),
	CHECK (year > 1900)
	);

CREATE TABLE Performer (
	id integer,
	name varchar(35),
	PRIMARY KEY (id)
	);

	/* I created a status table.  The benefits of doing this is that if say, there is a new type of status, it is easy to simply update the status table instead of updating the check constraint.
	This would also allow us to store additional information about the status if necessary.  The downside of this is that everytime the Casting table is used it must reference the status table.
	*/
CREATE TABLE Status (
	id integer,
	statusName VARCHAR(30),
	PRIMARY KEY (id)
);

CREATE TABLE Casting (
	movieId integer,
	performerId integer,
	statusID integer,
	FOREIGN KEY (movieId) REFERENCES Movie(id) ON DELETE CASCADE,
	FOREIGN KEY (performerId) REFERENCES Performer(id) ON DELETE SET NULL,
	FOREIGN KEY (statusID) REFERENCES Status(id) ON DELETE SET NULL
	);
	


CREATE SEQUENCE seq_movie 
MINVALUE 1 
START WITH 1 
INCREMENT BY 1 
NOCACHE;

	
-- Load sample data

-- create sequence for movie
INSERT INTO Movie VALUES (seq_movie.nextval,'Star Wars',1977,8.9);
INSERT INTO Movie VALUES (seq_movie.nextval,'Blade Runner',1982,8.6);

INSERT INTO Performer VALUES (1,'Harrison Ford');
INSERT INTO Performer VALUES (2,'Rutger Hauer');
INSERT INTO Performer VALUES (3,'The Mighty Chewbacca');
INSERT INTO Performer VALUES (4,'Rachael');

INSERT INTO Status VALUES (1, 'star');
INSERT INTO Status VALUES (2, 'costar');
INSERT INTO Status VALUES (3, 'extra');

INSERT INTO Casting VALUES (1,1,1);
INSERT INTO Casting VALUES (1,3,3);
INSERT INTO Casting VALUES (2,1,1);
INSERT INTO Casting VALUES (2,2,2);
INSERT INTO Casting VALUES (2,4,2);

/* QS: a) Yes, I would make an additional sequence for the Performer primary keys.  I would prefer for the primary keys to continually be incremented by 1 and if both the Performer and the Movie
are using the same primary key the primary key would not be increment by 1 in each individual table.  Also, if there is one sequence for each table, and I need to check the value of the 
sequence for a particular table, it is more useful for the value of seq_movie to be the value of the the primary key only for the movie.

b) No, if you use sequences this will allow you to use all of the values generated.  Also, if you are using the DDL command file to add primary keys to an existing database you should be careful
that the START WITH value is correct.  For instance, if I created a seq_performer with START WITH 1 and added a new value into performer with the seq_performer then there would be two PK with 1s.  

*/


