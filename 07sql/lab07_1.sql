
CREATE VIEW BIRTHDAY
AS SELECT firstName, lastName, TRUNC(MONTHS_BETWEEN(SYSDATE, birthdate)/12) AS age, birthdate as bDate
FROM Person;

--a
SELECT *
FROM BIRTHDAY
WHERE bDate => '01-Jan-1961' AND bDate < '01-Jan-1976';

--b
--updated 'Judy Heerema'
UPDATE person
SET birthdate = '07-FEB-1965'
WHERE id = 14;

SELECT *
FROM BIRTHDAY
WHERE bDate > '01-Jan-1961' AND bDate < '01-Jan-1976';

/*
The select statement before the update command did not return the updated record (Judy Heerema)
Where as the select statement after the update command returned Judy Herema
The views must be implemented via query modification, i.e. the view query is tranformed into a query on the underlying table
*/

--c
INSERT INTO BIRTHDAY VALUES ('Lydia', 'Cupery', 100, '01-Jan-1917');
/*
When running it, got the error 'virtual column not allowed here'

However, inserting into the below view would not create any errors because
1) there is an id field (if there was not an id field it would not work because we could not insert NULL for id) and 
2) there is not an computed variable we are inserting such as TRUNC(MONTHS_BETWEEN(SYSDATE, birthdate)/12) AS age

CREATE VIEW BIRTHDAY2
AS SELECT ID, firstName, lastName, birthdate
FROM Person;
INSERT INTO BIRTHDAY2 VALUES (100, 'Lydia', 'Cupery', '01-Jan-1917');
*/

--d 
/* when I dropped the view BIRTHDAY it did not affect the underying tables at all.
This made sense because the view was simply a mechanism to query the underlying tables.
I was curios to see if the updates I had made via a view (i.e. my experiments with Birthday2) remained even when I dropped the view,
so I dropped my view birthday 2 where I had inserted values in the table and the inserted values still remained 
Therefore, dropping the views did not affect the table */

drop view BIRTHDAY;
