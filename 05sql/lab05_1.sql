/* a */
SELECT * from person, household;
/* returns 128 */
SELECT COUNT(*) from person,household;

/* returns 16 */
SELECT COUNT(*) from person;
/* returns 8 */
SELECT COUNT(*) from household;

/*b*/
SELECT firstName, lastName, TO_CHAR(birthdate, 'DDD') as bDate
FROM Person
WHERE birthdate IS NOT NULL 
ORDER BY bDate;

