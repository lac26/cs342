/* a */
/* as a ROWNUM query */
SELECT *
FROM (SELECT * FROM person WHERE birthdate IS NOT NULL ORDER BY birthdate DESC)
WHERE ROWNUM = 1;

/* b */
SELECT P.ID, P.firstName, P.lastName
FROM Person P
WHERE P.firstName IN (	SELECT P.firstName
						FROM Person S
						WHERE S.firstName = P.firstName AND P.ID <> S.ID
						);
						
/* c */
/* names of people on music team BUT NOT in Byl's home group */
/* set operations query */
SELECT P.firstName, P.lastName
FROM Person P
WHERE EXISTS (SELECT * FROM PersonTeam PT WHERE P.ID = PT.personID and PT.teamName LIKE 'Music' )
Minus 
SELECT P.firstName, P.lastName
FROM Person P
WHERE EXISTS (SELECT * FROM Homegroup H WHERE H.ID = P.homeGroupID AND H.name LIKE 'Byl');