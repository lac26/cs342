-- This command file loads an experimental person database.
-- The data conforms to the following assumptions:
--     * People can have 0 or many team assignments.
--     * People can have 0 or many visit dates.
--     * Teams and visits don't affect one another.
--
-- CS 342, Spring, 2017
-- kvlinden

DROP TABLE PersonTeam;
DROP TABLE PersonVisit;

CREATE TABLE PersonTeam (
	personName varchar(10),
    teamName varchar(10)
	);

CREATE TABLE PersonVisit (
	personName varchar(10),
    personVisit date
	);

-- Load records for two team memberships and two visits for Shamkant.
INSERT INTO PersonTeam VALUES ('Shamkant', 'elders');
INSERT INTO PersonTeam VALUES ('Shamkant', 'executive');
INSERT INTO PersonVisit VALUES ('Shamkant', '22-FEB-2015');
INSERT INTO PersonVisit VALUES ('Shamkant', '1-MAR-2015');

-- Query a combined "view" of the data of the form View(name, team, visit).
SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;

/*
a)
Functional dependencies 
Is a mutlivalued dependency, the personName independently sets the teamName and the personVisit
personName ->> teamName
personName ->> personVisit
personName ->> teamName|personVisit
However, the relationship is already decomposed into two tables, so this follows the 4NF relation.

Meets BCNF since there are no functional dependencies.  (person Name does not determine the value of teamName nor does personName determine the value of personVisit)

b)This view shows up as a multivalued dependency where personName ->> teamName|personVisit.  And, unlike how the tables are set up, there are not to separate tables such as PersonTeam
and PersonVisit.  This is appears that the table has two MVDs personName ->> teamName and personName ->>personVisit which violates 4NF.  
This does not violate BNCF since again  there are no functional dependencies

c) The original schema is better because it does not require each combination of the person's team and person's visits to be entered in the DB - thus redundanctly repeating information in tuples.






*/