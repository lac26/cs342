@drop.sql
@schema.sql
@data.sql


/* 6.2 */
/* a */
SELECT TRUNC(AVG(MONTHS_BETWEEN(SYSDATE,P.birthdate)/12))
FROM Person P;
/* Has a default group that is the whole query result, i.e. everyone in Person  So it is an aggragrate function.*/


/* b */
SELECT H.ID, COUNT(*)
FROM Household H JOIN Person P ON H.ID = P.householdID
WHERE H.city = 'Grand Rapids'
GROUP BY H.ID
HAVING COUNT(*) > 1;

/* c */
SELECT H.ID, H.phoneNumber, COUNT(*)
FROM Household H JOIN Person ON H.ID = Person.householdID
WHERE H.city = 'Grand Rapids'
GROUP BY H.ID, H.phoneNumber
HAVING COUNT(*) > 1;
