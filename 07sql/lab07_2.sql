--set person with the id of 14 to have a birthday before 1961
UPDATE person
SET birthdate = '07-FEB-1960'
WHERE id = 14;

--create the materialized view
CREATE materialized VIEW BIRTHDAY FOR UPDATE
AS SELECT id, firstName, lastName, birthdate as bDate
FROM Person;

-- select all people with birthdays between 1961 and 1976
SELECT *
FROM BIRTHDAY
WHERE bDate > '01-Jan-1961' AND bDate < '01-Jan-1976';

--update person with id 14 again, this time to be in the range of 1961 - 1976
UPDATE person
SET birthdate = '07-FEB-1970'
WHERE id = 14;

--query again
SELECT *
FROM BIRTHDAY
WHERE bDate > '01-Jan-1961' AND bDate < '01-Jan-1976';

--Person with the id of 14 did not show up on the 2nd query even though the data had been adjusted.
--That is because the materialized view creates a temporary table that stores the data