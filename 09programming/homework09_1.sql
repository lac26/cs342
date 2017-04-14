--Get the movies directed by Clint Eastwood.
SET AUTOTRACE ON; 
SET SERVEROUTPUT ON;
SET TIMING ON;



--create index roleIndex on MovieDirector(directorID, movieId);

/*
set autotrace only;
select *
from movie m, moviedirector md, director d
where m.id = md.movieId 
and md.directorid = d.id
and d.firstName = 'Clint'
and d.lastName = 'Eastwood';
*/



/*
output with no indexes

Elapsed: 00:00:00.37

Execution Plan
----------------------------------------------------------
Plan hash value: 2681461605

--------------------------------------------------------------------------------
--------------

| Id  | Operation                    | Name          | Rows  | Bytes | Cost (%CP
U)| Time     |

--------------------------------------------------------------------------------
--------------

|   0 | SELECT STATEMENT             |               |     1 |    61 |   304   (
2)| 00:00:04 |

|   1 |  NESTED LOOPS                |               |       |       |
  |          |

|   2 |   NESTED LOOPS               |               |     1 |    61 |   304   (
2)| 00:00:04 |

|*  3 |    HASH JOIN                 |               |     1 |    31 |   302   (
2)| 00:00:04 |

|*  4 |     TABLE ACCESS FULL        | DIRECTOR      |     1 |    21 |    86   (
2)| 00:00:02 |

|   5 |     TABLE ACCESS FULL        | MOVIEDIRECTOR |   380K|  3717K|   215   (
1)| 00:00:03 |

|*  6 |    INDEX UNIQUE SCAN         | SYS_C007027   |     1 |       |     1   (
0)| 00:00:01 |

|   7 |   TABLE ACCESS BY INDEX ROWID| MOVIE         |     1 |    30 |     2   (
0)| 00:00:01 |

--------------------------------------------------------------------------------
--------------

*/

/* compute with MovieDirector index

Elapsed: 00:00:00.34

Execution Plan
----------------------------------------------------------
Plan hash value: 989481512

--------------------------------------------------------------------------------
----------------

| Id  | Operation                      | Name          | Rows  | Bytes | Cost (%
CPU)| Time     |

--------------------------------------------------------------------------------
----------------

|   0 | SELECT STATEMENT               |               |     4 |   244 |    12
 (0)| 00:00:01 |

|   1 |  NESTED LOOPS                  |               |       |       |
    |          |

|   2 |   NESTED LOOPS                 |               |     4 |   244 |    12
 (0)| 00:00:01 |

|   3 |    NESTED LOOPS                |               |     4 |   124 |     4
 (0)| 00:00:01 |

|   4 |     TABLE ACCESS BY INDEX ROWID| DIRECTOR      |     1 |    21 |     2
 (0)| 00:00:01 |

|*  5 |      INDEX RANGE SCAN          | DIRECTORINDEX |     1 |       |     1
 (0)| 00:00:01 |

|*  6 |     INDEX RANGE SCAN           | ROLEINDEX     |     4 |    40 |     2
 (0)| 00:00:01 |

|*  7 |    INDEX UNIQUE SCAN           | SYS_C007027   |     1 |       |     1
 (0)| 00:00:01 |

|   8 |   TABLE ACCESS BY INDEX ROWID  | MOVIE         |     1 |    30 |     2
 (0)| 00:00:01 |

--------------------------------------------------------------------------------
----------------

 */
 /*
create index directorIndex on Director(firstName, lastName);
 --adjust query 
 select d.firstName, d.lastName
from movie m, moviedirector md, director d
where m.id = md.movieId 
and md.directorid = d.id
and d.firstName = 'Clint'
and d.lastName = 'Eastwood';

drop index directorIndex;
drop index roleIndex;
*/

/* after adjusting query
Elapsed: 00:00:00.07

Execution Plan
----------------------------------------------------------
Plan hash value: 3980906824

--------------------------------------------------------------------------------
----

| Id  | Operation          | Name          | Rows  | Bytes | Cost (%CPU)| Time
   |

--------------------------------------------------------------------------------
----

|   0 | SELECT STATEMENT   |               |     1 |    31 |   302   (2)| 00:00:
04 |

|*  1 |  HASH JOIN         |               |     1 |    31 |   302   (2)| 00:00:
04 |

|*  2 |   TABLE ACCESS FULL| DIRECTOR      |     1 |    21 |    86   (2)| 00:00:
02 |

|*  3 |   TABLE ACCESS FULL| MOVIEDIRECTOR |   380K|  3717K|   215   (1)| 00:00:
03 |

--------------------------------------------------------------------------------
----
*/

/* with using director index
Elapsed: 00:00:00.06

Execution Plan
----------------------------------------------------------
Plan hash value: 4261312976

--------------------------------------------------------------------------------
--------------

| Id  | Operation                    | Name          | Rows  | Bytes | Cost (%CP
U)| Time     |

--------------------------------------------------------------------------------
--------------

|   0 | SELECT STATEMENT             |               |     4 |   124 |     4   (
0)| 00:00:01 |

|   1 |  NESTED LOOPS                |               |     4 |   124 |     4   (
0)| 00:00:01 |

|   2 |   TABLE ACCESS BY INDEX ROWID| DIRECTOR      |     1 |    21 |     2   (
0)| 00:00:01 |

|*  3 |    INDEX RANGE SCAN          | DIRECTORINDEX |     1 |       |     1   (
0)| 00:00:01 |

|*  4 |   INDEX RANGE SCAN           | ROLEINDEX     |     4 |    40 |     2   (
0)| 00:00:01 |

--------------------------------------------------------------------------------
--------------
*/

--create index group_bys from director(id, firstName, lastName); no effect
-- create index first_last_name from moviedirector(firstName || ' , ' || lastName); no effect

/*
select d.firstName || ' , ' || d.lastName, count(1)
from director d, moviedirector md
where md.directorid = d.id
group by d.id, d.firstName, d.lastName
having count(*) > 200;
*/
--without any adjustments
/*
Elapsed: 00:00:00.17

Execution Plan
----------------------------------------------------------
Plan hash value: 2646178372

--------------------------------------------------------------------------------
--------------

| Id  | Operation            | Name          | Rows  | Bytes |TempSpc| Cost (%CP
U)| Time     |

--------------------------------------------------------------------------------
--------------

|   0 | SELECT STATEMENT     |               | 19033 |   483K|       |  1833   (
1)| 00:00:22 |

|*  1 |  FILTER              |               |       |       |       |
  |          |

|   2 |   HASH GROUP BY      |               | 19033 |   483K|    11M|  1833   (
1)| 00:00:22 |

|*  3 |    HASH JOIN         |               |   380K|  9665K|  2800K|   745   (
1)| 00:00:09 |

|   4 |     TABLE ACCESS FULL| DIRECTOR      | 86880 |  1781K|       |    86   (
2)| 00:00:02 |

|   5 |     TABLE ACCESS FULL| MOVIEDIRECTOR |   380K|  1858K|       |   215   (
1)| 00:00:03 |

--------------------------------------------------------------------------------
--------------
*/
--try other things...

select a.id, a.firstName, a.lastName
from Actor a, Role r, Movie m
where a.id = r.actorId
and r.movieId = m.id
and (select count(*) from movie where r.movieid = m.id) > 10
group by a.id, a.firstName, a.lastName
having avg(m.rank) > 8.5;



