SET AUTOTRACE ON;
SET SERVEROUTPUT ON;
SET TIMING ON;


--a)
/*
	SELECT COUNT(*)
	FROM Movie;
	
	SELECT SUM(1)
	FROM Movie;
	*/
		
/*	
DECLARE
	intOut integer;
BEGIN 
	FOR i IN 1..1000 LOOP
		SELECT COUNT(*)
		INTO intout
		FROM Movie;
	END LOOP;
END;
/
--time elapsed: 5.42

DECLARE
	intOut integer;
BEGIN 
	FOR i IN 1..1000 LOOP
		SELECT COUNT(1)
		INTO intout
		FROM Movie;
	END LOOP;
END;
/
--time elapsed: 5.41

DECLARE
	intOut integer;
BEGIN 
	FOR i IN 1..1000 LOOP
		SELECT SUM(1)
		INTO intout
		FROM Movie;
	END LOOP;
END;
/
--time elapsed: 11.32
*/
/*
Count(1) and Count(*) are very similar
Sum(1) is similar to count and has the same execution plan.  However, it takes longer, perhaps because the way the values are computed.
*/

--b
/*
SET AUTOTRACE TRACEONLY;
SELECT * 
FROM movie m, role r, actor a
WHERE m.id = r.movieID
AND a.id = r.actorID;
--time elapsed: 13:25

SET AUTOTRACE TRACEONLY;
SELECT * 
FROM role r, actor a, movie m
WHERE m.id = r.movieID
AND a.id = r.actorID;
--time elapsed; 13:34
*/

--the execution plan of both of these is identical, even though the tables are in different orders in the from clause
--the execution plan for both of the queries first does a full table access on movie, then actor, then role

--c
/*
SET AUTOTRACE TRACEONLY;
SELECT *
FROM Movie JOIN Role 
ON id = movieID;
--execution time 9:54

SET AUTOTRACE TRACEONLY;
SELECT *
FROM Movie JOIN Role 
ON id+2 = movieID+1;
--execution time 9:79
*/

--though the execution plan for both is the same, the 2nd one (where adding value to an id) take longer.  Thus would be becaue the computation would take extra time.

--d

/*
--running it once
SELECT COUNT(*)
FROM MOVIE;
--time 00:00:00.01
--time per query: 00:00:00.01

--running it 100 times
DECLARE
	intOut integer;
BEGIN 
	FOR i IN 1..100 LOOP
		SELECT COUNT(*)
		INTO intout
		FROM Movie;
	END LOOP;
END;
/
--time 00:00:00.55
--time per query: 00:00:00.0055
--about half the time per query

--running it 1000 times
DECLARE
	intOut integer;
BEGIN 
	FOR i IN 1..1000 LOOP
		SELECT COUNT(*)
		INTO intout
		FROM Movie;
	END LOOP;
END;
/
--time 00:00:05.41
--time per query 00:00:00.00541
--does not get more efficient as do more
*/

--it makes sense that the queries after the first query take less time because there is a buffer cache for full-table scans

CREATE INDEX role_index ON MovieDirector(directorId, movieId);

SET AUTOTRACE TRACEONLY;

DECLARE
	intOut integer;
BEGIN 
	FOR i IN 1..1000 LOOP
		SELECT COUNT(*)
		INTO intout
		FROM director d, moviedirector, movie m
		WHERE d.id = directorId
		AND m.id = movieId
		AND m.id = 370890
		AND d.id =  18370;
		END LOOP;
END;
/
--procedure takes 00:00:00.01

SELECT COUNT(*)
		FROM director d, moviedirector, movie m
		WHERE d.id = directorId
		AND m.id = movieId
		AND m.id = 370890
		AND d.id =  18370;
		
DROP INDEX role_index;

DECLARE
	intOut integer;
BEGIN 
	FOR i IN 1..1000 LOOP
		SELECT COUNT(*)
		INTO intout
		FROM director d, moviedirector, movie m
		WHERE d.id = directorId
		AND m.id = movieId
		AND m.id = 370890
		AND d.id =  18370;
		END LOOP;
END;
/
--procedure takes 00:00:04:35, significantly longer


		
SELECT COUNT(*)
		FROM director d, moviedirector, movie m
		WHERE d.id = directorId
		AND m.id = movieId
		AND m.id = 370890
		AND d.id =  18370;

/*
The second procedure taking significantly longer makes sense because the procedures have differnet executions.
With index:
-------------------------------------------------------------------------------
| Id  | Operation         | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |            |     1 |    10 |     3   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE   |            |     1 |    10 |            |          |
|*  2 |   INDEX RANGE SCAN| ROLE_INDEX |     1 |    10 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------------
Without index:
--------------------------------------------------------------------------------
----

| Id  | Operation          | Name          | Rows  | Bytes | Cost (%CPU)| Time
   |

--------------------------------------------------------------------------------
----

|   0 | SELECT STATEMENT   |               |     1 |    10 |   215   (1)| 00:00:
03 |

|   1 |  SORT AGGREGATE    |               |     1 |    10 |            |
   |

|*  2 |   TABLE ACCESS FULL| MOVIEDIRECTOR |     1 |    10 |   215   (1)| 00:00:
03 |

--------------------------------------------------------------------------------

Without the index, does a TABLE ACCESS FULL instead of INDEX RANGE SCAN
*/


