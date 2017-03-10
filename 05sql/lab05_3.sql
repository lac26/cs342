/* exercise 5.3 */

/* a */

SELECT DISTINCT P1.lastName || ', ' ||  P1.firstName || ' and ' || P2.firstName ||' - ' || H.phoneNumber ||  ' - ' || H.street AS Traditional_Family_Entries
FROM ((Person P1 JOIN Person P2 ON P1.householdID = P2.householdID)
JOIN Household H ON H.ID = P1.householdID)
WHERE (P1.householdRole like 'husband' and P2.householdRole like 'wife');

/* b */
SELECT DISTINCT P1.lastName || ', ' ||  P1.firstName || ' and ' || P2.firstName 
|| ' '|| P2.lastName ||' - ' || H.phoneNumber ||  ' - ' || H.street AS NONTraditional_Family_Entries
FROM ((Person P1 JOIN Person P2 ON P1.householdID = P2.householdID)
JOIN Household H ON H.ID = P1.householdID)
WHERE ((P1.householdRole like 'husband' and P2.householdROle like 'wife') 
or (P1.householdRole like 'wife' and P2.householdROle like 'husband') 
) and P1.id < P2.id;

/* c */
SELECT S.lastName || ',' || S.firstName || ' - ' || H.phoneNumber || ' - ' || H.street AS WITH_SINGLES
FROM (Person S JOIN Household H ON S.householdID = H.ID)
WHERE S.householdRole LIKE 'single'
UNION
SELECT DISTINCT P1.lastName || ', ' ||  P1.firstName || ' and ' || P2.firstName 
|| ' '|| P2.lastName ||' - ' || H.phoneNumber ||  ' - ' || H.street 
FROM ((Person P1 JOIN Person P2 ON P1.householdID = P2.householdID)
JOIN Household H ON H.ID = P1.householdID)
WHERE ((P1.householdRole like 'husband' and P2.householdROle like 'wife') 
or (P1.householdRole like 'wife' and P2.householdROle like 'husband') 
) and P1.id < P2.id;